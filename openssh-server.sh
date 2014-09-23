# Run the build scripts
apt-get update

# Install openssh-server.
apt-get install -y --no-install-recommends openssh-server

# Config openssh-server.
mkdir /var/run/sshd

## Install default SSH key for root.
mkdir -p /root/.ssh && \
chmod 700 /root/.ssh && \
chown root:root /root/.ssh
chmod 644 /etc/insecure_key* && \
chown root:root /etc/insecure_key*

# Clean up system
apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
