#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WWW_SRC="$SCRIPT_DIR/www"
NGINX_SRC="$SCRIPT_DIR/nginx/vaporwave.conf"

WWW_DEST="/opt/vapor"
NGINX_DEST="/etc/nginx/conf.d/vaporwave.conf"

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

echo "Setting file permissions"
sudo find "$WWW_DEST" -type d -exec chmod 755 {} \;
sudo find "$WWW_DEST" -type f -exec chmod 644 {} \;

echo "Installing nginx config"
sudo mkdir -p "$(dirname "$NGINX_DEST")"
sudo cp "$NGINX_SRC" "$NGINX_DEST"

echo "Testing nginx config"
sudo nginx -t

echo "Reloading nginx"
sudo systemctl reload nginx

echo "Deploy complete: http://74.208.35.96/vapor/"
