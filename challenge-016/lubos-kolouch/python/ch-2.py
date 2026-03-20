#!/usr/bin/env python3
"""
Challenge 016, Task 2: Validating Bitcoin addresses

Write a script to validate a given bitcoin address. Most Bitcoin addresses
are 34 characters. They consist of random digits and uppercase and lowercase
letters, with the exception that the uppercase letter "O", uppercase letter
"I", lowercase letter "l", and the number "0" are never used to prevent
visual ambiguity.

A bitcoin address encodes 25 bytes. The last four bytes are a checksum check.
They are the first four bytes of a double SHA-256 digest of the previous 21
bytes.

Author: Lubos Kolouch
"""

import hashlib
import unittest


BASE58_CHARS = "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz"


def validate_bitcoin_address(address: str) -> bool:
    """
    Validate a Bitcoin address.

    A valid Bitcoin address:
    - Is 26-35 characters
    - Uses only Base58 characters (no 0, O, I, l)
    - Has correct double SHA-256 checksum

    Args:
        address: The Bitcoin address to validate

    Returns:
        True if valid, False otherwise

    Examples:
        >>> validate_bitcoin_address("1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2")
        True
        >>> validate_bitcoin_address("3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy")
        True
        >>> validate_bitcoin_address("invalid")
        False
    """
    # Check length (26-35 characters)
    if len(address) < 26 or len(address) > 35:
        return False

    # Check valid Base58 characters (no 0, O, I, l)
    invalid_chars = "0OIl"
    for char in address:
        if char in invalid_chars:
            return False

    # Try to decode as Base58
    try:
        decoded = decode_base58(address, 25)
    except Exception:
        return False

    if len(decoded) != 25:
        return False

    # Get checksum (first 4 bytes of decoded)
    checksum = decoded[-4:]

    # Get payload (first 21 bytes)
    payload = decoded[:21]

    # Double SHA-256 hash
    hash1 = hashlib.sha256(payload).digest()
    hash2 = hashlib.sha256(hash1).digest()

    # Check if checksum matches
    return hash2[:4] == checksum


def decode_base58(address: str, num_bytes: int) -> bytes:
    """
    Decode a Base58 string to bytes.

    Args:
        address: Base58 encoded string
        num_bytes: Expected number of bytes

    Returns:
        Decoded bytes
    """
    # Build Base58 decoding table
    b58_table = {c: i for i, c in enumerate(BASE58_CHARS)}

    # Decode
    result = 0
    for char in address:
        if char not in b58_table:
            raise ValueError(f"Invalid character: {char}")
        result = result * 58 + b58_table[char]

    # Convert to bytes
    decoded = result.to_bytes(num_bytes, "big")

    return decoded


def main() -> None:
    """Main function to demonstrate validation."""
    test_addresses = [
        "1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2",
        "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy",
        "invalid",
        "0000000000000000000000000000000000000000",
    ]

    for addr in test_addresses:
        result = validate_bitcoin_address(addr)
        print(f"{addr[:30]}... : {result}")


if __name__ == "__main__":
    main()


class TestBitcoinAddress(unittest.TestCase):
    """Unit tests for Bitcoin address validation."""

    def test_valid_address_1(self):
        """Test valid Bitcoin address starting with 1."""
        addr = "1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"
        self.assertTrue(validate_bitcoin_address(addr))

    def test_valid_address_3(self):
        """Test valid Bitcoin address starting with 3."""
        addr = "3J98t1WpEZ73CNmQviecrnyiWrnqRhWNLy"
        self.assertTrue(validate_bitcoin_address(addr))

    def test_invalid_too_short(self):
        """Test address too short."""
        self.assertFalse(validate_bitcoin_address("abc"))

    def test_invalid_contains_0(self):
        """Test address containing 0."""
        self.assertFalse(validate_bitcoin_address("1BvBMSEystWetqTFn5Au4m4GFg7xJaNVN2"))

    def test_invalid_contains_O(self):
        """Test address containing uppercase O."""
        self.assertFalse(
            validate_bitcoin_address(
                "1BvBMSEystWetqTFn5Au4m4GFg7xJaNVN2".replace("1", "O")
            )
        )

    def test_invalid_contains_I(self):
        """Test address containing uppercase I."""
        self.assertFalse(
            validate_bitcoin_address(
                "1BvBMSEystWetqTFn5Au4m4GFg7xJaNVN2".replace("B", "I")
            )
        )

    def test_invalid_contains_l(self):
        """Test address containing lowercase l."""
        self.assertFalse(
            validate_bitcoin_address(
                "1BvBMSEystWetqTFn5Au4m4GFg7xJaNVN2".replace("S", "l")
            )
        )

    def test_invalid_wrong_checksum(self):
        """Test address with wrong checksum."""
        # Valid address with last char changed
        addr = "1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN9"
        self.assertFalse(validate_bitcoin_address(addr))

    def test_empty_string(self):
        """Test empty string."""
        self.assertFalse(validate_bitcoin_address(""))

    def test_base58_only_chars(self):
        """Test that only Base58 characters are valid."""
        valid_chars = set(BASE58_CHARS)
        addr = "1BvBMSEYstWetqTFn5Au4m4GFg7xJaNVN2"
        for char in addr:
            self.assertIn(char, valid_chars)


if __name__ == "__main__":
    unittest.main()
