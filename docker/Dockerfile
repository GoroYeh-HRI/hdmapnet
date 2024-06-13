FROM pytorch/pytorch:1.11.0-cuda11.3-cudnn8-devel
# FROM ghcr.io/honda-research-institute/hdmapnet:v4

# Set the working directory in the container
# WORKDIR /app

# Copy the requirements file into the container
COPY requirement.txt .

# Install the required packages
RUN pip3 install -r requirement.txt

RUN pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118

# Install openGL
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys A4B469963BF863CC
RUN apt-get update && \
    apt-get install -y curl 
RUN apt update && apt install -y sudo

RUN apt-get install -y libgl1-mesa-glx
RUN apt-get install -y libglib2.0-dev

# Copy the rest of the application code into the container
# COPY . .

# Add container user
ARG USERNAME=hridev
ARG RUN_AS_UID=1000
ARG RUN_AS_GID=1000
RUN useradd -l -m -d /home/${USERNAME} ${USERNAME} \
  && echo "${USERNAME}:${USERNAME}" | chpasswd \
  && usermod --shell /bin/bash ${USERNAME} \
  && usermod -aG sudo ${USERNAME} \
  && mkdir -p /etc/sudoers.d \
  && echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/${USERNAME} \
  && chmod 0440 /etc/sudoers.d/${USERNAME} \
  # Replace user/group id
  && usermod --uid ${RUN_AS_UID} ${USERNAME} \
  && groupmod --gid ${RUN_AS_GID} ${USERNAME} \
  && touch /home/${USERNAME}/.sudo_as_admin_successful \
  && chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

# RUN apt-get update 
# Fix UID
# https://github.com/boxboat/fixuid
USER root
RUN USER=${USERNAME} && \
  GROUP=${USERNAME} && \
  curl -SsL https://github.com/boxboat/fixuid/releases/download/v0.4/fixuid-0.4-linux-amd64.tar.gz | tar -C /usr/local/bin -xzf - && \
  chown root:root /usr/local/bin/fixuid && \
  chmod 4755 /usr/local/bin/fixuid && \
  mkdir -p /etc/fixuid && \
  printf "user: $USER\ngroup: $GROUP\n" > /etc/fixuid/config.yml

USER ${USERNAME}
# Set Entrypoint to Fix UID
ENTRYPOINT ["fixuid"]