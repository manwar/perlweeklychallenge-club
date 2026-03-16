#!/usr/bin/env python3
import re
import unittest


def decrypt_string(s: str) -> str:
    # Use re.sub with a replacement function
    # Match 2 digits followed by # OR 1 digit
    return re.sub(
        r"(\d{2})#|(\d)",
        lambda m: chr(ord("a") + int(m.group(1)) - 1)
        if m.group(1)
        else chr(ord("a") + int(m.group(2)) - 1),
        s,
    )


class TestDecryptString(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(decrypt_string("1326#"), "acz")
        self.assertEqual(decrypt_string("10#11#12"), "jkab")
        self.assertEqual(decrypt_string("25#"), "y")
        self.assertEqual(decrypt_string("123"), "abc")


if __name__ == "__main__":
    unittest.main()
