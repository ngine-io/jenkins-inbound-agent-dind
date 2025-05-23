# Use the official Jenkins agent image as the base
FROM jenkins/inbound-agent:latest

USER root

# Install Docker
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Configure Docker to run as non-root user
RUN usermod -aG docker jenkins

# Enable DinD
RUN mkdir -p /var/lib/docker
VOLUME /var/lib/docker
