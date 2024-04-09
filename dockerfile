# FROM ubuntu:22.04

# RUN apt update && apt install -y openssh-server
# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# RUN apt install -y ufw
# RUN useradd -m -s /bin/bash lex
# RUN echo "lex:2589" | chpasswd
# RUN ufw allow 22

# EXPOSE 22

# ENTRYPOINT service ssh start && bash

# FROM ubuntu:22.04

# RUN apt update && apt install -y openssh-server ruby-full build-essential zlib1g-dev

# RUN echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
# RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
# RUN echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
# RUN /bin/bash -c "source ~/.bashrc"

# RUN gem install jekyll bundler

# RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# RUN apt install -y ufw
# # RUN useradd -m -s /bin/bash lex
# # RUN echo "lex:2589" | chpasswd
# RUN ufw allow 22

# EXPOSE 22
# EXPOSE 4000

# ENTRYPOINT service ssh start && bash
# ENTRYPOINT ["service", "ssh", "start", "bash"]

FROM ubuntu:22.04

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y openssh-server ruby-full build-essential zlib1g-dev sudo

# RUN useradd -m lex
# RUN echo "lex:lex" | chpasswd && adduser lex sudo

RUN adduser --disabled-password --gecos '' lex
RUN adduser lex sudo
RUN echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

USER lex

ENV HOME="/home/lex"
ENV GEM_HOME="$HOME/gems"
ENV PATH="$HOME/gems/bin:$PATH"

RUN echo '# Install Ruby Gems to ~/gems' >> ~/.bashrc
RUN echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
RUN echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
RUN /bin/bash -c "source ~/.bashrc"

RUN gem install jekyll bundler

RUN sudo sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

# RUN sudo apt install -y ufw
# RUN useradd -m -s /bin/bash lex
# RUN echo "lex:2589" | chpasswd
# RUN sudo ufw allow 22

# EXPOSE 22
EXPOSE 4000
EXPOSE 35729

ENTRYPOINT bash