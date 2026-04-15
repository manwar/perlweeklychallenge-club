#!/usr/bin/env python3

import unittest
ch_1 = __import__("ch-1")
ch_2 = __import__("ch-2")


class TestClass(unittest.TestCase):
    def test_ch_1(self):
        self.assertEqual(
            ch_1.valid_tag("Cooking with 5 ingredients!"),
            "#cookingWithIngredients"
        )
        self.assertEqual(
            ch_1.valid_tag("the-last-of-the-mohicans"),
            "#thelastofthemohicans"
        )
        self.assertEqual(ch_1.valid_tag("  extra spaces here"), "#extraSpacesHere")
        self.assertEqual(
            ch_1.valid_tag("iPhone 15 Pro Max Review"),
            "#iphoneProMaxReview"
        )
        self.assertEqual(
            ch_1.valid_tag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"),
            "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"
        )

    def test_ch_2(self):
        self.assertEqual(ch_2.group_division("RakuPerl", 4, "*"), ["Raku", "Perl"])
        self.assertEqual(ch_2.group_division("Python", 5, "0"), ["Pytho", "n0000"])
        self.assertEqual(ch_2.group_division("12345", 3, "x"), ["123", "45x"])
        self.assertEqual(ch_2.group_division("HelloWorld", 3, "_"), ["Hel", "loW", "orl", "d__"])
        self.assertEqual(ch_2.group_division("AI", 5, "!"), ["AI!!!"])


if __name__ == "__main__":
    unittest.main()
