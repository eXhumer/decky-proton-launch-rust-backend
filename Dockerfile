# Docker image of SteamOS Holo from SteamDeckHomebrew
FROM ghcr.io/steamdeckhomebrew/holo-base:latest

# Install rustup and openssl
RUN pacman -Sy --noconfirm pkg-config rustup openssl && rustup install stable

# Setup rust environment
RUN rustup default stable

# Set the backend directory as the working directory
WORKDIR /backend

ENTRYPOINT [ "/backend/entrypoint.sh" ]
