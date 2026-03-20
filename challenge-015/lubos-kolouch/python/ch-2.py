#!/usr/bin/env python3
"""
Challenge 015, Task 2: Vigenère cipher

Implement Vigenère cipher for encoding and decoding.

The Vigenère cipher is a method of encrypting alphabetic text by using
a series of interwoven Caesar ciphers, based on the letters of a keyword.

Author: Lubos Kolouch
"""

import unittest


def normalize_key(key: str) -> str:
    """
    Normalize the key by converting to uppercase and removing non-letters.

    Args:
        key: The encryption/decryption key

    Returns:
        Normalized key (uppercase letters only)

    Examples:
        >>> normalize_key("KEY")
        'KEY'
        >>> normalize_key("key")
        'KEY'
        >>> normalize_key("Key123")
        'KEY'
    """
    return "".join(c.upper() for c in key if c.isalpha())


def extend_key(key: str, text: str) -> str:
    """
    Extend the key to match the length of the text.

    Args:
        key: The normalized key
        text: The text to encrypt/decrypt

    Returns:
        Extended key matching text length

    Examples:
        >>> extend_key("KEY", "HELLO")
        'KEYKE'
        >>> extend_key("ABC", "HelloWorld")
        'ABCABCABCA'
    """
    key_length = len(key)
    if key_length == 0:
        return ""

    # Repeat key to match text length
    extended = (key * ((len(text) // key_length) + 1))[: len(text)]
    return extended


def char_shift(char: str, shift: int) -> str:
    """
    Shift a single character by the given amount.

    Args:
        char: Single alphabetic character
        shift: Number of positions to shift (can be negative)

    Returns:
        Shifted character (preserves case)

    Examples:
        >>> char_shift('A', 0)
        'A'
        >>> char_shift('A', 1)
        'B'
        >>> char_shift('A', -1)
        'Z'
        >>> char_shift('a', 1)
        'b'
    """
    if not char.isalpha():
        return char

    is_upper = char.isupper()
    base = ord("A") if is_upper else ord("a")

    # Handle negative shifts
    shifted = (ord(char) - base + shift) % 26 + base
    return chr(shifted)


def vigenere_encipher(plaintext: str, key: str) -> str:
    """
    Encrypt plaintext using Vigenère cipher.

    Each letter is shifted by the corresponding letter in the key.
    Non-alphabetic characters are removed from plaintext before encryption.

    Args:
        plaintext: The text to encrypt
        key: The encryption key

    Returns:
        Encrypted ciphertext

    Examples:
        >>> vigenere_encipher("HELLO", "KEY")
        'RIJVS'
        >>> vigenere_encipher("ATTACKATDAWN", "LEMON")
        'LXFOPVEFRNHR'
    """
    key = normalize_key(key)
    if not key:
        return plaintext

    # Extract only alphabetic characters from plaintext
    alpha_chars = [c for c in plaintext if c.isalpha()]
    if not alpha_chars:
        return ""

    result = []
    key_idx = 0

    for char in alpha_chars:
        # A=0, B=1, ..., Z=25
        shift = ord(key[key_idx % len(key)].upper()) - ord("A")
        result.append(char_shift(char, shift))
        key_idx += 1

    return "".join(result)


def vigenere_decipher(ciphertext: str, key: str) -> str:
    """
    Decrypt ciphertext using Vigenère cipher.

    Each letter is shifted back by the corresponding letter in the key:
    P_i = (C_i - K_i) mod 26

    Args:
        ciphertext: The text to decrypt
        key: The decryption key

    Returns:
        Decrypted plaintext

    Examples:
        >>> vigenere_decipher("RIJVS", "KEY")
        'HELLO'
        >>> vigenere_decipher("LXFOPVEFRNHR", "LEMON")
        'ATTACKATDAWN'
    """
    key = normalize_key(key)
    if not key:
        return ciphertext

    # Extract only alphabetic characters from ciphertext
    alpha_chars = [c for c in ciphertext if c.isalpha()]
    if not alpha_chars:
        return ""

    result = []
    key_idx = 0

    for char in alpha_chars:
        # Shift backwards
        shift = -(ord(key[key_idx % len(key)].upper()) - ord("A"))
        result.append(char_shift(char, shift))
        key_idx += 1

    return "".join(result)


def vigenere(plaintext: str, key: str, decode: bool = False) -> str:
    """
    Encrypt or decrypt using Vigenère cipher.

    Args:
        plaintext: The text to encrypt/decrypt
        key: The encryption/decryption key
        decode: If True, decrypt; if False, encrypt

    Returns:
        Transformed text

    Examples:
        >>> vigenere("HELLO", "KEY")
        'RIJVS'
        >>> vigenere("RIJVS", "KEY", decode=True)
        'HELLO'
    """
    if decode:
        return vigenere_decipher(plaintext, key)
    return vigenere_encipher(plaintext, key)


def main() -> None:
    """Main function to demonstrate Vigenère cipher."""
    # Classic example
    plaintext = "ATTACKATDAWN"
    key = "LEMON"

    ciphertext = vigenere_encipher(plaintext, key)
    decrypted = vigenere_decipher(ciphertext, key)

    print(f"Plaintext: {plaintext}")
    print(f"Key: {key}")
    print(f"Ciphertext: {ciphertext}")
    print(f"Decrypted: {decrypted}")

    # Another example
    print("\nAnother example:")
    plaintext2 = "HELLO"
    key2 = "KEY"
    ciphertext2 = vigenere_encipher(plaintext2, key2)
    print(f"'{plaintext2}' with key '{key2}' -> '{ciphertext2}'")


if __name__ == "__main__":
    main()


class TestVigenereCipher(unittest.TestCase):
    """Unit tests for Vigenère cipher."""

    def test_normalize_key(self):
        """Test key normalization."""
        self.assertEqual(normalize_key("KEY"), "KEY")
        self.assertEqual(normalize_key("key"), "KEY")
        self.assertEqual(normalize_key("Key123"), "KEY")
        self.assertEqual(normalize_key("K-E-Y"), "KEY")

    def test_extend_key(self):
        """Test key extension."""
        self.assertEqual(extend_key("KEY", "HELLO"), "KEYKE")
        self.assertEqual(extend_key("ABC", "HelloWorld"), "ABCABCABCA")
        self.assertEqual(extend_key("KEY", ""), "")

    def test_char_shift(self):
        """Test character shifting."""
        self.assertEqual(char_shift("A", 0), "A")
        self.assertEqual(char_shift("A", 1), "B")
        self.assertEqual(char_shift("A", 25), "Z")
        self.assertEqual(char_shift("Z", -1), "Y")
        self.assertEqual(char_shift("a", 1), "b")
        self.assertEqual(char_shift("Z", 1), "A")
        self.assertEqual(char_shift("A", -1), "Z")

    def test_encipher_hello_key(self):
        """Test encrypting HELLO with KEY."""
        result = vigenere_encipher("HELLO", "KEY")
        self.assertEqual(result, "RIJVS")

    def test_encipher_attack_lemon(self):
        """Test classic example with LEMON."""
        result = vigenere_encipher("ATTACKATDAWN", "LEMON")
        self.assertEqual(result, "LXFOPVEFRNHR")

    def test_decipher_rijvs_key(self):
        """Test decrypting RIJVS with KEY."""
        result = vigenere_decipher("RIJVS", "KEY")
        self.assertEqual(result, "HELLO")

    def test_decipher_lxfopvefrnhr(self):
        """Test decrypting the classic example."""
        result = vigenere_decipher("LXFOPVEFRNHR", "LEMON")
        self.assertEqual(result, "ATTACKATDAWN")

    def test_vigenere_function_encode(self):
        """Test vigenere function for encoding."""
        result = vigenere("HELLO", "KEY")
        self.assertEqual(result, "RIJVS")

    def test_vigenere_function_decode(self):
        """Test vigenere function for decoding."""
        result = vigenere("RIJVS", "KEY", decode=True)
        self.assertEqual(result, "HELLO")

    def test_preserve_case(self):
        """Test that case is preserved."""
        result = vigenere_encipher("Hello", "KEY")
        self.assertEqual(result, "Rijvs")

    def test_preserve_non_alpha(self):
        """Test that non-alphabetic characters are stripped."""
        # Non-alpha chars are stripped from plaintext before encryption
        result = vigenere_encipher("HELLO, WORLD!", "KEY")
        self.assertEqual(result, "RIJVSUYVJN")

    def test_empty_text(self):
        """Test with empty text."""
        self.assertEqual(vigenere_encipher("", "KEY"), "")
        self.assertEqual(vigenere_decipher("", "KEY"), "")

    def test_empty_key(self):
        """Test with empty key - should return original text."""
        self.assertEqual(vigenere_encipher("HELLO", ""), "HELLO")

    def test_roundtrip(self):
        """Test that encrypting then decrypting gives original (alpha only)."""
        # Note: non-alpha characters are stripped during encryption
        original = "TheQuickBrownFoxJumpsOverTheLazyDog"
        key = "SECRET"

        encrypted = vigenere_encipher(original, key)
        decrypted = vigenere_decipher(encrypted, key)

        self.assertEqual(decrypted, original)


if __name__ == "__main__":
    unittest.main()
