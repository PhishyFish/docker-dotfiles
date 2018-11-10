# docker-dotfiles

Set up your coding environment with Docker.  
Replace `vickie` with your desired username in the Dockerfile!

Referenced heavily from [@casualjim/dot-files](https://github.com/casualjim/dot-files).

## Instructions

```sh
# build image
docker build -t <image-name> .
# run one-off container
docker run --rm -it <image-name>
```

```sh
# associate local image with Docker repository
docker tag <image-name> <username>/<repo-name>
# publish build
docker push <username>/<repo-name>
```

## What's included

### zsh

- `zsh`
- **zgen**
  - .zshrc [[1-30]](https://github.com/PhishyFish/docker-dotfiles/blob/master/.zshrc#L1-L30)
  - Dependencies
    - `git`

### bat

Dockerfile [[36-40]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L36-L40)

- Dependencies
  - `curl`
  - `jq`

### Go

.zshrc [[54-55]](https://github.com/PhishyFish/docker-dotfiles/blob/master/.zshrc#L54-L55) | Dockerfile  [[41-43]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L41-L43)

- Dependencies
  - `wget`
  - `tar`

### Docker

Dockerfile [[44-52]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L44-L52) [[59]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L59)

- Dependencies
  - `curl`
  - `apt-transport-https`
  - `ca-certificates`
  - `gnupg2`
  - `software-properties-common`

### Python

- `python`
- `python-pip`
- `python3`
- `python3-pip`

### Node.js

- **Yarn**
  - Dockerfile [[53-56]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L53-L56) [[60]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L60)
  - Dependencies
    - `curl`
    - `gnupg2`
- **Node Version Manager**
  - .zshrc [[16]](https://github.com/PhishyFish/docker-dotfiles/blob/master/.zshrc#L16) [[49-52]](https://github.com/PhishyFish/docker-dotfiles/blob/master/.zshrc#L49-L52) | Dockerfile [[93-95]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L93-L95)
  - Dependencies
    - [zgen](#zsh)
- **Node + NPM** (latest)
  - Dockerfile [[96-97]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L96-L97)

### Ruby

- **rbenv**
  - .zshrc [[41-47]](https://github.com/PhishyFish/docker-dotfiles/blob/master/.zshrc#L41-L47) | Dockerfile [[83-85]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L83-L85)
- **Ruby 2.5.3**
  - Dockerfile [[86-87]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L86-L87)
- gems
  - Dockerfile [[88-92]](https://github.com/PhishyFish/docker-dotfiles/blob/master/Dockerfile#L88-L92)
  - `bundler`
  - `pry`
  - `rails`
  - `rspec`
- Dependencies
  - `build-essential`
  - `libssl-dev`
  - `libreadline-dev`
  - `zlib1g-dev`
