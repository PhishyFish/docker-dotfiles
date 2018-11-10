FROM debian:9-slim

RUN \
  # stop script execution if error occurs
  set -e &&\
  # update package list with no output except errors
  apt-get update -qq &&\
  # install following packages quietly, answering 'yes' to all prompts
  apt-get install -yqq \
    curl \
    wget \
    jq \
    sudo \
    tar \
    gzip \
    zsh \
    git \
    python \
    python3 \
    python-pip \
    python3-pip \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    apt-transport-https \
    ca-certificates \
    gnupg2 \
    software-properties-common &&\
  # set up user and wheel accounts
  useradd -m -s /bin/zsh vickie &&\
  mkdir -p /etc/sudoers.d &&\
  echo "vickie ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/vickie &&\
  echo "wheel ALL = (ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel &&\
  chmod 0400 /etc/sudoers.d/vickie /etc/sudoers.d/wheel &&\
  # install bat (cat with syntax highlighting)
  curl -o /tmp/bat.deb -L --progress \
    $(curl -s https://api.github.com/repos/sharkdp/bat/releases/latest | jq -r \
    '.assets[] | select(.name | contains("amd64.deb") and contains("bat_")) | .browser_download_url') &&\
  dpkg -i /tmp/bat.deb &&\
  # install Go
  wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz -P /tmp/go &&\
  tar -C /usr/local -xzf /tmp/go/go1.11.2.linux-amd64.tar.gz &&\
  # add Docker
  curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&\
  add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" &&\
  curl -L \
    "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" \
    -o /usr/local/bin/docker-compose &&\
  chmod +x /usr/local/bin/docker-compose &&\
  # add Yarn
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - &&\
  echo "deb https://dl.yarnpkg.com/debian/ stable main" \
    | tee /etc/apt/sources.list.d/yarn.list &&\
  # update list and install remaining packages
  apt-get update -qq &&\
  apt-get install -yqq docker-ce &&\
  apt-get install -yqq --no-install-recommends yarn &&\
  # cleanup
  apt-get autoremove -yqq &&\
  apt-get clean -y &&\
  apt-get autoclean -yqq &&\
  rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/* /usr/share/doc/* \
    /usr/share/locale/* /var/cache/debconf/*-old

# add Tini
ENV TINI_VERSION v0.18.0
ADD \
  https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static-amd64 \
  /bin/tini
RUN chmod +x /bin/tini

# change user
USER vickie
ADD --chown=vickie .zshrc /home/vickie/.zshrc
WORKDIR /home/vickie

RUN \
  # source .zshrc
  zsh -c "source /home/vickie/.zshrc" &&\
  # initialize rbenv
  export PATH="$HOME/.rbenv/bin:$PATH" &&\
  eval "$(rbenv init -)" &&\
  # install and set Ruby version
  rbenv install 2.5.3 && rbenv global 2.5.3 &&\
  # install Bundler, Pry, Rails, and RSpec
  echo "gem: --no-document" > $HOME/.gemrc &&\
  gem install bundler pry rails rspec &&\
  # match commands across all installed Ruby versions
  rbenv rehash &&\
  # initialize nvm
  export NVM_DIR="$HOME/.nvm" &&\
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" &&\
  # install and set latest Node.js version
  nvm install node && nvm use node

SHELL [ "/bin/zsh", "-c" ]
ENTRYPOINT [ "/bin/tini", "--" ]
CMD ["zsh"]
