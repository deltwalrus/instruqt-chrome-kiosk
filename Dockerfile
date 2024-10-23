# Use a lightweight Ubuntu base image
FROM ubuntu:20.04

# Set DEBIAN_FRONTEND to noninteractive to suppress prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install necessary packages and dependencies, including unzip and xpra
RUN apt-get update && apt-get install -y \
    x11vnc \
    xvfb \
    fluxbox \
    dbus-x11 \
    xterm \
    wget \
    ca-certificates \
    gnupg \
    curl \
    net-tools \
    tree \
    vim-tiny \
    gstreamer1.0-vaapi \
    unzip \
    libappindicator3-1 \
    fonts-liberation \
    xdg-utils \
    --no-install-recommends && \
    wget -O - https://xpra.org/gpg.asc | apt-key add - && \
    echo "deb https://xpra.org/ focal main" > /etc/apt/sources.list.d/xpra.list && \
    apt-get update && \
    apt-get install -y xpra && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Google Chrome without snap
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
    dpkg -i google-chrome-stable_current_amd64.deb || apt-get -fy install && \
    rm google-chrome-stable_current_amd64.deb

# Set environment variables
ENV DISPLAY=:99
ENV XPRA_HTML=on
ENV XPRA_XVFB=on
ENV START_URL=https://www.instruqt.com

# Copy XPRA settings
COPY default-settings.txt /etc/xpra/html5-client/default-settings.txt

# Copy startup script and set permissions
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

# Install a Chrome extension (unzipped)
###
# Leaving this here in case custom extensions are required later
# NB: FORK THE REPO! Do *NOT* install extensions via this repo! This
# is meant to be general-purpose.
###

#RUN mkdir -p /usr/src/extensions 
#COPY c10e-removeNavMenuAdmin.xpi /usr/src/extensions/c10e-removeNavMenuAdmin.xpi
#RUN mkdir -p /usr/src/extensions/c10e-removeNavMenuAdmin && \
#    unzip /usr/src/extensions/c10e-removeNavMenuAdmin.xpi -d /usr/src/extensions/c10e-removeNavMenuAdmin

# Copy Chrome policy JSON to the correct location
COPY chrome-policies.json /etc/opt/chrome/policies/managed/chrome-policies.json

# Expose the port for XPRA
EXPOSE 8080

# Set entry point
ENTRYPOINT ["/usr/local/bin/start.sh"]

