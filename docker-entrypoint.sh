#!/bin/sh
set -e

if [ -n "$ADGUARD_ADMIN_PASS" ]; then
  echo "Setting AdGuard admin password from environment..."
  HASH=$(adguardhome -s hash "$ADGUARD_ADMIN_PASS")
  sed -i "s|password:.*|password: \"$HASH\"|" /opt/adguardhome/conf/AdGuardHome.yaml
fi

mkdir -p /var/log/adguard
exec /opt/adguardhome/AdGuardHome -c /opt/adguardhome/conf/AdGuardHome.yaml -w /opt/adguardhome/work >>/var/log/adguard/adguard.log 2>&1
