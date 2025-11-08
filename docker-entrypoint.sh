#!/bin/sh
set -e

ADGUARD_BIN="/opt/adguardhome/AdGuardHome"
CONF_FILE="/opt/adguardhome/conf/AdGuardHome.yaml"
LOG_DIR="/var/log/adguard"

if [ -n "$ADGUARD_ADMIN_PASS" ]; then
  echo "Generating bcrypt hash for AdGuard admin password..."
  HASH=$(python3 -c "import bcrypt, os; print(bcrypt.hashpw(os.environ['ADGUARD_ADMIN_PASS'].encode(), bcrypt.gensalt()).decode())")
  echo "Setting AdGuard admin password from environment..."

  if [ -f "$CONF_FILE" ]; then
    # Safely replace password line if it exists
    if grep -q '^ *password:' "$CONF_FILE"; then
      sed -i "s|^ *password:.*|    password: \"$HASH\"|" "$CONF_FILE"
    else
      echo "  - name: admin" >>"$CONF_FILE"
      echo "    password: \"$HASH\"" >>"$CONF_FILE"
    fi
  else
    echo "Warning: $CONF_FILE not found — skipping password injection."
  fi
fi

mkdir -p "$LOG_DIR"
echo "Starting AdGuard Home..."
exec "$ADGUARD_BIN" -c "$CONF_FILE" -w /opt/adguardhome/work >>"$LOG_DIR/adguard.log" 2>&1
