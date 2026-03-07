# NFC Card Cloning

This project focuses on reading and cloning NFC cards with a Primark Easy NFC writer. The application is designed to handle 7-byte card information, supporting older and newer versions of NFC cards.

## Features

1. **Read and Write NFC Cards**:
    - Source card (older version) → Destination card (newer version).
2. **Simulation**:
    - Test the process without physical NFC hardware.
3. **GitHub Actions**:
    - Automates tests and deployments.

## Requirements

- [Primark Easy NFC Writer](https://example.com) (or similar hardware).
- Python 3.10+
- pipenv (or another package manager).

## Getting Started

1. Clone the repository:
    ```bash
    git clone https://github.com/your-user/nfc-card-cloning.git
    cd nfc-card-cloning
    ```
2. Setup Python environment:
    ```bash
    pipenv install --dev
    pipenv shell
    ```
3. Run the simulator:
    ```bash
    python src/simulator.py
    ```

## Disclaimers

- Ensure you have the legal right to clone the NFC cards you are working with.
- Unauthorized card cloning is strictly prohibited and may be illegal.
