#!/bin/bash

SSM_USERNAME=ssm-user
LOG_DIR="/home/$SSM_USERNAME"
LOG_FILE="$LOG_DIR/$(date +%d-%m-%Y-%Hh-%Mm)-ec2-installation.log"

useradd -m $SSM_USERNAME
echo "$SSM_USERNAME ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/$SSM_USERNAME
mkdir -p "$LOG_DIR"
chown $SSM_USERNAME:$SSM_USERNAME "$LOG_DIR"

{
    echo ""
    echo "==================================="
    echo "========INSTALLATION LOGS=========="
    echo "==================================="
    echo ""
    echo "run at $(date)"
    echo ""
} >> "$LOG_FILE"

apt-get update -y >> "$LOG_FILE" 2>&1
apt-get install -y ca-certificates curl >> "$LOG_FILE" 2>&1

install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
chmod a+r /etc/apt/keyrings/docker.asc

echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" \
  > /etc/apt/sources.list.d/docker.list

apt-get update -y >> "$LOG_FILE" 2>&1
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >> "$LOG_FILE" 2>&1

usermod -aG docker $SSM_USERNAME
systemctl enable --now docker

# clone repo
git clone -b ${repo_branch} https://github.com/Lucas4lves/devops-ec2-based.git /opt/devops-ec2-based >> "$LOG_FILE" 2>&1

# ensure ssm-user has docker group on every SSM agent start
mkdir -p /etc/systemd/system/amazon-ssm-agent.service.d
cat > /etc/systemd/system/amazon-ssm-agent.service.d/docker-group.conf <<EOF
[Service]
ExecStartPre=/bin/sh -c 'usermod -aG docker ssm-user || true'
EOF
systemctl daemon-reload

chown $SSM_USERNAME:$SSM_USERNAME "$LOG_FILE"
