#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WWW_SRC="$SCRIPT_DIR/www"
NGINX_SRC="$SCRIPT_DIR/nginx/vaporwave.conf"

WWW_DEST="/var/www/vapor"
NGINX_DEST="/etc/nginx/sites-available/vaporwave"
NGINX_ENABLED="/etc/nginx/sites-enabled/vaporwave"

if [[ ! -d "$WWW_SRC" ]]; then
    echo "Missing web source directory: $WWW_SRC" >&2
    exit 1
fi

if [[ ! -f "$NGINX_SRC" ]]; then
    echo "Missing nginx config: $NGINX_SRC" >&2
    exit 1
fi

echo "Creating web root at $WWW_DEST"
sudo mkdir -p "$WWW_DEST"

echo "Copying web files"
sudo cp -R "$WWW_SRC"/. "$WWW_DEST"/

echo "Installing nginx config"
sudo cp "$NGINX_SRC" "$NGINX_DEST"

if [[ ! -L "$NGINX_ENABLED" ]]; then
    echo "Enabling nginx site"
    sudo ln -s "$NGINX_DEST" "$NGINX_ENABLED"
fi

echo "Testing nginx config"
sudo nginx -t

echo "Reloading nginx"
sudo systemctl reload nginx

echo "Deploy complete: http://74.208.35.96/vapor/"
