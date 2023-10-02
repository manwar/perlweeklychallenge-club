#!/usr/bin/env python
# -*- coding: utf-8 -*-

import unittest


def decoded_list(s):
    return sorted(_decode(s))


def _decode(s):
    if s == '':
        return ['']

    decodings = []

    # Decode one digit
    if s[0] != '0':
        char = chr(int(s[0]) + ord('A') - 1)
        for sub_decoding in _decode(s[1:]):
            decodings.append(char + sub_decoding)

    # Decode two digits
    if len(s) > 1 and int(s[:2]) <= 26:
        char = chr(int(s[:2]) + ord('A') - 1)
        for sub_decoding in _decode(s[2:]):
            decodings.append(char + sub_decoding)

    return decodings


class TestDecodedList(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(decoded_list('11'), ['AA', 'K'])
        self.assertEqual(decoded_list('1115'), [
                         'AAAE', 'AAO', 'AKE', 'KAE', 'KO'])
        self.assertEqual(decoded_list('127'), ['ABG', 'LG'])


if __name__ == '__main__':
    unittest.main()
