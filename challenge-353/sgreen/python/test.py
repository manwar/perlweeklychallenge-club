#!/usr/bin/env python3

import unittest
ch_1 = __import__('ch-1')
ch_2 = __import__('ch-2')


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        sentences_1 = ["Hello world", "This is a test", "Perl is great"]
        sentences_2 = ["Single"]
        sentences_3 = [
            "Short",
            "This sentence has seven words in total",
            "A B C",
            "Just four words here",
        ]
        sentences_4 = ["One", "Two parts", "Three part phrase", ""]
        sentences_5 = [
            "The quick brown fox jumps over the lazy dog",
            "A",
            "She sells seashells by the seashore",
            "To be or not to be that is the question",
        ]

        self.assertEqual(ch_1.max_words(sentences_1), 4)
        self.assertEqual(ch_1.max_words(sentences_2), 1)
        self.assertEqual(ch_1.max_words(sentences_3), 7)
        self.assertEqual(ch_1.max_words(sentences_4), 3)
        self.assertEqual(ch_1.max_words(sentences_5), 10)

    def test_ch_2(self):
        codes = [
            ["A123", "B_456", "C789", "D@1", "E123"],
            ["Z_9", "AB_12", "G01", "X99", "test"],
            ["_123", "123", "", "Coupon_A", "Alpha"],
            ["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"],
            ["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"],
        ]

        names = [
            ["electronics", "restaurant", "electronics", "pharmacy", "grocery"],
            ["pharmacy", "electronics", "grocery", "electronics", "unknown"],
            ["restaurant", "electronics", "electronics", "pharmacy", "grocery"],
            ["electronics", "electronics", "grocery", "grocery"],
            ["restaurant", "electronics", "grocery", "pharmacy", "electronics"],
        ]

        status = [
            ["true", "false", "true", "true", "true"],
            ["true", "true", "false", "true", "true"],
            ["true", "true", "false", "true", "true"],
            ["true", "true", "true", "true"],
            ["true", "true", "true", "true", "false"],
        ]

        results = [
            [True, False, True, False, True],
            [True, True, False, True, False],
            [True, True, False, True, True],
            [True, True, True, True],
            [True, True, True, True, False],
        ]

        self.assertEqual(ch_2.validate_codes(codes[0], names[0], status[0]), results[0])
        self.assertEqual(ch_2.validate_codes(codes[1], names[1], status[1]), results[1])
        self.assertEqual(ch_2.validate_codes(codes[2], names[2], status[2]), results[2])
        self.assertEqual(ch_2.validate_codes(codes[3], names[3], status[3]), results[3])
        self.assertEqual(ch_2.validate_codes(codes[4], names[4], status[4]), results[4])


if __name__ == '__main__':
    unittest.main()
