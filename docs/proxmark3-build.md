# Proxmark3 Easy build (Linux)

Deze handleiding installeert de **Proxmark3 client + firmware** voor legitieme analyse/testdoeleinden.

## 1) Dependencies (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install -y git build-essential pkg-config libreadline-dev \
  libusb-0.1-4 libusb-dev libbz2-dev liblz4-dev libwhereami-dev \
  libncurses5-dev zlib1g-dev libssl-dev qtbase5-dev
```

> Als een package ontbreekt op jouw distro, installeer het equivalent.

## 2) Clone officiële repo

```bash
git clone https://github.com/RfidResearchGroup/proxmark3.git
cd proxmark3
```

## 3) Build

```bash
make clean
make -j"$(nproc)"
```

## 4) Flash (Easy hardware aangesloten)

```bash
# Controleer device, vaak /dev/ttyACM0
ls /dev/ttyACM*

# Flash fullimage voor de aangesloten Proxmark3
sudo ./pm3-flash-all
```

## 5) Start client

```bash
./pm3
# of expliciet:
./pm3 -p /dev/ttyACM0
```

## 6) Basis read-only checks

```text
hw version
hf search
hf 14a info
hf mf info
```

## Troubleshooting

- **Geen toegang tot /dev/ttyACM0**
  - tijdelijk: `sudo ./pm3 -p /dev/ttyACM0`
  - of user aan `dialout` toevoegen en opnieuw inloggen:
    ```bash
    sudo usermod -aG dialout "$USER"
    ```
- **Build faalt op missende libs**
  - installeer de gemelde `-dev` package en run opnieuw `make -j"$(nproc)"`.
- **Device niet gedetecteerd**
  - andere USB-kabel/poort proberen, check `dmesg | tail`.

## Security & legal

Gebruik Proxmark3 alleen op kaarten/systemen waarvoor je toestemming hebt.
Deze repo/documentatie bevat bewust geen clone- of write-instructies.
