FROM node:20.16.0

ARG USERNAME=dev
ARG USER_UID=1001
ARG USER_GID=$USER_UID

# Install Packages
RUN apt update && apt install -y less bash-completion && apt clean
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && ./aws/install

# # User Setting
RUN groupadd --gid $USER_GID $USERNAME \
    && useradd --uid $USER_UID --gid $USER_GID -m $USERNAME -s /bin/bash \
    #
    # [Optional] Add sudo support. Omit if you don't need to install software after connecting.
    && apt-get update \
    && apt-get install -y sudo \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME \
    && chmod 0440 /etc/sudoers.d/$USERNAME
USER $USERNAME

# Bash Setting
RUN echo 'export PS1="[\u@\h \W] $ "' >> ~/.bashrc
