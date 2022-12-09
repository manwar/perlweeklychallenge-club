import re
import unittest

"""
 Week 194:

    https://theweeklychallenge.org/blog/perl-weekly-challenge-194

    Task 2: Frequency Equalizer
    Submitted by: Mohammad S Anwar
    You are given a string made of alphabetic characters only, a-z.
    
    Write a script to determine whether removing only one character can make the frequency of the remaining characters the same.
"""


class FrequencyEqualizer:
    @staticmethod
    def frequency_equalizer(string: str) -> bool:
        character_frequency_map = dict()

        for character in string:
            if character in character_frequency_map:
                character_frequency_map[character] += 1
            else:
                character_frequency_map[character] = 1

        unique_frequencies = list(set(character_frequency_map.values()))

        return True if len(unique_frequencies) == 2 and abs(unique_frequencies[0] - unique_frequencies[1]) == 1 else False


class FrequencyEqualizerTestCases(unittest.TestCase):
    def test_digital_clock(self):
        self.assertTrue(FrequencyEqualizer.frequency_equalizer("abbc"), 'Test case 1 Failed.')
        self.assertTrue(FrequencyEqualizer.frequency_equalizer("xyzyyxz"), 'Test case 2 Failed.')
        self.assertFalse(FrequencyEqualizer.frequency_equalizer("xzxz"), 'Test case 3 Failed.')


if __name__ == '__main__':
    unittest.main()
