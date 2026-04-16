#!/usr/bin/env python

import re
import unittest


def generate_tag(caption: str) -> str:
    """
    Generate a sanitized social media tag from a video caption.

    Args:
        caption: The video caption string.

    Returns:
        A sanitized tag string starting with #.
    """

    # 1. Sanitise the String (keep only letters and spaces for now)
    caption = re.sub(r"[^a-zA-Z\s]", "", caption)
    caption = caption.lstrip()
    caption = caption.lower()

    # 2. Format as camelCase
    # space(s) followed by a letter becomes uppercase letter
    caption = re.sub(r"\s+([a-z])", lambda m: m.group(1).upper(), caption)

    # Remove any remaining spaces
    caption = re.sub(r"\s+", "", caption)

    # 3. Enforce Length
    if len(caption) > 99:
        caption = caption[:99]

    return "#" + caption


class TestGenerateTag(unittest.TestCase):
    def test_examples(self):
        self.assertEqual(
            generate_tag("Cooking with 5 ingredients!"), "#cookingWithIngredients"
        )
        self.assertEqual(
            generate_tag("the-last-of-the-mohicans"), "#thelastofthemohicans"
        )
        self.assertEqual(generate_tag("  extra spaces here"), "#extraSpacesHere")
        self.assertEqual(
            generate_tag("iPhone 15 Pro Max Review"), "#iphoneProMaxReview"
        )
        self.assertEqual(
            generate_tag(
                "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
            ),
            "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn",
        )
        self.assertEqual(
            generate_tag("i#P!h$o%n-e 1 7 9 5 (P)_r-o - M]a[x Review"),
            "#iphoneProMaxReview",
        )
        self.assertEqual(generate_tag(""), "#")


if __name__ == "__main__":
    unittest.main()
