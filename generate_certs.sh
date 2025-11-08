#!/bin/bash
set -e

DOMAIN="dns.home.unorthodoxdev.net"
ADGUARD_CONF_DIR="./adguard/conf"
NGINX_CERT_DIR="./nginx/certs"

mkdir -p "$ADGUARD_CONF_DIR" "$NGINX_CERT_DIR"

echo "🛠 Generating self-signed certificate for $DOMAIN..."

# Generate the private key and certificate valid for 365 days
openssl req -x509 -newkey rsa:4096 \
  -keyout "$ADGUARD_CONF_DIR/AdGuardHome.key" \
  -out "$ADGUARD_CONF_DIR/AdGuardHome.crt" \
  -days 365 -nodes \
  -sha256 \
  -subj "/CN=$DOMAIN" \
  -addext "subjectAltName=DNS:$DOMAIN"

# Copy same cert to NGINX cert directory
cp "$ADGUARD_CONF_DIR/AdGuardHome.key" "$NGINX_CERT_DIR/server.key"
cp "$ADGUARD_CONF_DIR/AdGuardHome.crt" "$NGINX_CERT_DIR/server.crt"

echo "✅ Certificates generated:"
echo "   - AdGuard: $ADGUARD_CONF_DIR/AdGuardHome.crt / .key"
echo "   - NGINX:   $NGINX_CERT_DIR/server.crt / .key"
