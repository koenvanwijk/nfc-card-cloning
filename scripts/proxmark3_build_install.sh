#!/usr/bin/env bash
set -euo pipefail

# Build + install Proxmark3 (RfidResearchGroup) on Debian/Ubuntu.
# Installs deps, clones/updates repo in /opt/proxmark3, builds, and symlinks pm3.

sudo bash -lc 'set -e
apt update
apt install -y git build-essential pkg-config libreadline-dev \
  libusb-0.1-4 libusb-dev libbz2-dev liblz4-dev libwhereami-dev \
  libncurses5-dev zlib1g-dev libssl-dev qtbase5-dev
cd /opt || exit 1
if [ ! -d proxmark3 ]; then
  git clone https://github.com/RfidResearchGroup/proxmark3.git
fi
cd proxmark3
git pull --ff-only
make clean
make -j"$(nproc)"
ln -sf /opt/proxmark3/pm3 /usr/local/bin/pm3
'

echo "[OK] Proxmark3 built. Run: pm3 -p /dev/tty_reader"
