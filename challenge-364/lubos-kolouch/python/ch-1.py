#!/usr/bin/env python3
import re
import unittest


def decrypt_string(s: str) -> str:
    # Match ### first then #
    # Or use re.sub with a custom function or just multiple calls.
    # The order is key to avoid misinterpreting 10# as 1 then 0 (invalid)

    # We can use a lambda or function with re.sub
    # Replace ### patterns first
    s = re.sub(r"(\d{2})#", lambda m: chr(96 + int(m.group(1))), s)
    # Then replace individual digits
    s = re.sub(r"(\d)", lambda m: chr(96 + int(m.group(1))), s)
    return s


class TestDecryptString(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(decrypt_string("10#11#12"), "jkab")
        self.assertEqual(decrypt_string("1326#"), "acz")

    def test_extra(self):
        self.assertEqual(decrypt_string("123456789"), "abcdefghi")
        self.assertEqual(decrypt_string("25#"), "y")


if __name__ == "__main__":
    unittest.main()
