#!/bin/bash
apt install -y sshpass
SSH_USER="root"
SSH_HOST="localhost"
SSH_PORT="4242"
SSH_PASSWORD="mahnux-fegti7-kAqwid"
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" 'exit'
SSH_USER="welee"
SSH_HOST="localhost"
SSH_PORT="4242"
SSH_PASSWORD="mahnux-fegti7-kAqwid"
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" 'exit'
SSH_USER="welee"
SSH_HOST="localhost"
SSH_PORT="22"
SSH_PASSWORD="mahnux-fegti7-kAqwid"
sshpass -p "$SSH_PASSWORD" ssh -o StrictHostKeyChecking=no -p "$SSH_PORT" "$SSH_USER@$SSH_HOST" 'exit'
apt purge -y sshpass
