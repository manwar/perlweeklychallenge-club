#!/usr/bin/env python3

import re
import unittest

def valid_tag(caption):
    chunks = caption.split()

    words = [re.sub(r'[^a-zA-Z]', '', word) for word in chunks]
    words = [word for word in words if word]

    if not words:
        return ""

    first_word = words[0].lower()
    other_words = [w.lower().capitalize() for w in words[1:]]

    tag = "#" + first_word + "".join(other_words)

    return tag[:100]

class TestValidTag(unittest.TestCase):
    def test_cases(self):
        examples = [
            ("Cooking with 5 ingredients!", "#cookingWithIngredients"),
            ("the-last-of-the-mohicans", "#thelastofthemohicans"),
            ("  extra spaces here", "#extraSpacesHere"),
            ("iPhone 15 Pro Max Review", "#iphoneProMaxReview"),
            ("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!",
             "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"),
        ]
        for inp, expected in examples:
            with self.subTest(inp=inp):
                self.assertEqual(valid_tag(inp), expected)

if __name__ == "__main__":
    unittest.main()
