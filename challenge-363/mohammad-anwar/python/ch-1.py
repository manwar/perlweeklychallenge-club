#!/usr/bin/env python3

import unittest
import re
from word2number import w2n

examples = {
    "aa — two vowels and zero consonants":     "true",
    "iv — one vowel and one consonant":        "true",
    "hello - three vowels and two consonants": "false",
    "aeiou — five vowels and zero consonants": "true",
    "aei — three vowels and zero consonants":  "true",
}

def lie_detector(s):
    match = re.match(r'^([^-—]+)', s)

    if not match:
        return "false"

    word = match.group(1).strip()
    vow  = len(re.findall(r'[aeiou]', word, re.IGNORECASE))
    con  = len(re.findall(r'[b-df-hj-np-tv-z]', word, re.IGNORECASE))

    m = re.search(r'([\w\s]+?)\s+vowels?\b.*?([\w\s]+?)\s+consonants?\b', s)
    if m:
        v_phrase = m.group(1).strip()
        c_phrase = m.group(2).strip()

        try:
            v_claim = w2n.word_to_num(v_phrase)
            c_claim = w2n.word_to_num(c_phrase)
            return "true" if v_claim == vow and c_claim == con else "false"
        except ValueError:
            return "false"

    return "false"

class TestLieDetector(unittest.TestCase):
    def test_all(self):
        for s, expected in examples.items():
            self.assertEqual(lie_detector(s), expected)

if __name__ == '__main__':
    unittest.main()
