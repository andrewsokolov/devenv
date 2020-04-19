FROM ubuntu:18.04

RUN apt-get update
RUN apt-get install -y curl docker.io
RUN apt-get install -y zsh nano

RUN curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube

RUN mkdir -p /usr/local/bin/
RUN install minikube /usr/local/bin/

RUN adduser admin
RUN usermod -a -G docker admin
RUN usermod -a -G root admin

USER admin

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN sed -i 's/robbyrussell/pygmalion/g' ~/.zshrc
RUN sed -i 's/git/git history-substring-search history go golang git-extras docker docker-compose npm nvm osx/g' ~/.zshrc

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | zsh

WORKDIR /home/admin

ARG SSH_PRIVATE_KEY
RUN mkdir -p /home/admin/.ssh
RUN echo "${SSH_PRIVATE_KEY}" > /home/admin/.ssh/id_rsa
RUN chmod 400 /home/admin/.ssh/id_rsa

ENV ENVIRONMENT=development

RUN mkdir -p /home/admin/Projects
