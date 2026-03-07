class NFCCardSimulator:
    """
    Simulates NFC card read and write processes
    for testing without hardware.
    """

    def __init__(self):
        self.memory = bytearray(7)  # Simulate a 7-byte NFC card

    def read_card(self):
        print(f"Read Card Data: {self.memory.hex()}")
        return self.memory

    def write_card(self, data: bytes):
        if len(data) != 7:
            raise ValueError("Data must be exactly 7 bytes.")
        self.memory = bytearray(data)
        print(f"Card written successfully. New Data: {self.memory.hex()}")


def main():
    print("NFC Simulator Running...")

    simulator = NFCCardSimulator()

    # Demo: Write to card
    simulator.write_card(b'\x01\x02\x03\x04\x05\x06\x07')

    # Demo: Read from card
    simulator.read_card()


if __name__ == "__main__":
    main()