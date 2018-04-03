FROM debian:stretch

RUN apt-get -q update \
 && apt-get -q -y install sudo \
    \
 && adduser --gecos ",,," --disabled-password docker \
 && echo "docker ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/docker \
    \
 && sudo rm -rf /var/lib/apt/lists/* /var/cache/apt/* /var/cache/debconf/* /var/log/*

USER docker:docker
WORKDIR /home/docker

RUN sudo apt-get -q update \
 && sudo apt-get -q -y install alsa-utils python3-dev python3-venv \
 && python3 -m venv env \
 && env/bin/pip install --upgrade pip setuptools wheel \
    \
 && sudo apt-get -q -y install portaudio19-dev libffi-dev libssl-dev \
 && env/bin/pip install --upgrade google-assistant-library \
 && env/bin/pip install --upgrade google-assistant-sdk[samples] \
 && env/bin/pip install --upgrade google-auth-oauthlib[tool] \
    \
 && sudo rm -rf /var/lib/apt/lists/* /var/cache/apt/* /var/cache/debconf/* /var/log/*

RUN mkdir bin \
 && sed -i -e 's/#\(force_color_prompt=yes\)/\1/' .bashrc \
 && echo "\n\nsource env/bin/activate" >> .bashrc

ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8
