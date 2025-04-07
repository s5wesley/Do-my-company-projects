#!/bin/bash

# === Config ===
PROJECT_DIR="bookstack-deployment"
COMPOSE_FILE="$PROJECT_DIR/docker-compose.yml"
ENV_FILE="$PROJECT_DIR/.env"

echo "🚀 Creating BookStack deployment folder..."
mkdir -p "$PROJECT_DIR"

echo "📄 Writing .env file..."
cat > "$ENV_FILE" <<EOF
# Global
PUID=1000
PGID=1000
TZ=Etc/UTC

# BookStack App Settings
APP_URL=https://bookstack.edusuc.net
APP_KEY=base64:6um2Xi48STZ+dqwdHJOCgta1/VKJhdUj4gFjZEfchu4=

# MariaDB Database Settings
MYSQL_ROOT_PASSWORD=bookstack
MYSQL_DATABASE=bookstackapp
MYSQL_USER=bookstack
MYSQL_PASSWORD=bookstack
DB_PORT=3306

# Gmail SMTP Settings
MAIL_DRIVER=smtp
MAIL_HOST=smtp.gmail.com
MAIL_PORT=465
MAIL_USERNAME=info@devopseasylearning.com
MAIL_PASSWORD=Edhfgnurn\$@!HDK
MAIL_ENCRYPTION=tls
MAIL_FROM=info@devopseasylearning.com
MAIL_FROM_NAME=BookStack
EOF

echo "📄 Writing docker-compose.yml file..."
cat > "$COMPOSE_FILE" <<EOF
version: '3.8'

services:
  bookstack_db:
    image: linuxserver/mariadb
    container_name: bookstack-db
    restart: unless-stopped
    environment:
      PUID: \${PUID}
      PGID: \${PGID}
      TZ: \${TZ}
      MYSQL_ROOT_PASSWORD: \${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: \${MYSQL_DATABASE}
      MYSQL_USER: \${MYSQL_USER}
      MYSQL_PASSWORD: \${MYSQL_PASSWORD}
    volumes:
      - bookstack_db_data:/var/lib/mysql
    networks:
      - proxy_network

  bookstack:
    image: linuxserver/bookstack:latest
    container_name: bookstack-app
    restart: unless-stopped
    depends_on:
      - bookstack_db
    environment:
      PUID: \${PUID}
      PGID: \${PGID}
      TZ: \${TZ}
      APP_URL: \${APP_URL}
      APP_KEY: \${APP_KEY}
      DB_HOST: bookstack_db
      DB_PORT: \${DB_PORT}
      DB_USER: \${MYSQL_USER}
      DB_PASS: \${MYSQL_PASSWORD}
      DB_DATABASE: \${MYSQL_DATABASE}
      MAIL_DRIVER: \${MAIL_DRIVER}
      MAIL_HOST: \${MAIL_HOST}
      MAIL_PORT: \${MAIL_PORT}
      MAIL_USERNAME: \${MAIL_USERNAME}
      MAIL_PASSWORD: \${MAIL_PASSWORD}
      MAIL_ENCRYPTION: \${MAIL_ENCRYPTION}
      MAIL_FROM: \${MAIL_FROM}
      MAIL_FROM_NAME: \${MAIL_FROM_NAME}
    volumes:
      - bookstack_config:/config
    ports:
      - "6875:80"
    networks:
      - proxy_network

volumes:
  bookstack_config:
  bookstack_db_data:

networks:
  proxy_network:
    driver: bridge
EOF

echo "✅ Configuration files created at: $PROJECT_DIR"

