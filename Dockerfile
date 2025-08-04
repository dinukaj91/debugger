FROM ubuntu:24.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install base tools
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    wget \
    telnet \
    dnsutils \
    iputils-ping \
    iproute2 \
    net-tools \
    traceroute \
    whois \
    lsof \
    strace \
    htop \
    procps \
    file \
    gnupg \
    tcpdump \
    mysql-client \
    postgresql-client \
    bash \
    bash-completion

# Enable bash-completion for all users
RUN echo "source /etc/profile.d/bash_completion.sh" >> /etc/bash.bashrc

# Install MySQL client
RUN sudo apt-get update && sudo apt-get install -y mysql-client

# Install PostgreSQL client
RUN sudo apt-get update && sudo apt-get install -y postgresql-client

# Install MongoDB Shell (mongosh)
RUN curl -fsSL https://pgp.mongodb.com/server-6.0.asc | gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-server-6.0.gpg > /dev/null
RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" \
    | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN sudo apt-get update && sudo apt-get install -y mongodb-mongosh

# Clean up
RUN sudo apt-get clean && sudo rm -rf /var/lib/apt/lists/*
