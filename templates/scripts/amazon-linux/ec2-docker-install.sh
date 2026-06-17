#!/bin/bash

SSM_USERNAME=ssm-user
LOG_DIR="/home/$SSM_USERNAME"
LOG_FILE="$LOG_DIR/$(date +%d-%m-%Y-%Hh-%Mm)-ec2-installation.log"

useradd -m $SSM_USERNAME
groupadd docker
usermod -aG docker $SSM_USERNAME

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

dnf install -y docker docker-compose-plugin >> "$LOG_FILE" 2>&1
systemctl enable --now docker

chown $SSM_USERNAME:$SSM_USERNAME "$LOG_FILE"
