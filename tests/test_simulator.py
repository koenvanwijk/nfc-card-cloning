import unittest
from src.simulator import NFCCardSimulator

class TestNFCCardSimulator(unittest.TestCase):

    def setUp(self):
        self.simulator = NFCCardSimulator()

    def test_initial_memory(self):
        self.assertEqual(self.simulator.read_card(), bytearray(7), "Initial memory should be 7 zeroed bytes.")

    def test_write_and_read(self):
        data = b'\x01\x02\x03\x04\x05\x06\x07'
        self.simulator.write_card(data)
        self.assertEqual(self.simulator.read_card(), data, "Read data should match written data.")

    def test_invalid_write(self):
        with self.assertRaises(ValueError):
            self.simulator.write_card(b'\x01\x02')  # Too short

if __name__ == "__main__":
    unittest.main()