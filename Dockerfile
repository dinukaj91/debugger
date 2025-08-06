FROM ubuntu:24.04

# Set non-interactive mode for apt
ENV DEBIAN_FRONTEND=noninteractive

# Install base tools
RUN apt-get update && apt-get install -y \
    sudo \
    curl \
    wget \
    unzip \
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
    bash-completion \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

# Enable bash-completion for all users
RUN echo "source /etc/profile.d/bash_completion.sh" >> /etc/bash.bashrc

# Install MongoDB Shell (mongosh)
RUN curl -fsSL https://pgp.mongodb.com/server-6.0.asc | gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-server-6.0.gpg > /dev/null
RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-6.0.gpg ] https://repo.mongodb.org/apt/ubuntu jammy/mongodb-org/6.0 multiverse" \
    | sudo tee /etc/apt/sources.list.d/mongodb-org-6.0.list
RUN sudo apt-get update && sudo apt-get install -y mongodb-mongosh

# Install MongoRestore and MongoDump
RUN sudo apt-get install -y mongodb-database-tools

# Install AWS CLI v2
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "/tmp/awscliv2.zip" \
 && unzip /tmp/awscliv2.zip -d /tmp \
 && /tmp/aws/install \
 && rm -rf /tmp/aws /tmp/awscliv2.zip

# Install MySQL CLI (from official MySQL APT repo for compatibility with Ubuntu 24.04)
RUN curl -fsSL https://dev.mysql.com/get/mysql-apt-config_0.8.29-1_all.deb -o mysql-apt-config.deb && \
    DEBIAN_FRONTEND=noninteractive dpkg -i mysql-apt-config.deb && \
    apt-get update && \
    apt-get install -y mysql-client && \
    rm -f mysql-apt-config.deb

# Clean up
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

