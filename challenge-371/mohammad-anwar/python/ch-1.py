#!/usr/bin/env python3

import unittest

def missing_character(seq):
    nums = [ord(char) - ord('a') + 1 if char != '?' else None for char in seq]

    x, y = None, None

    # 2. Identify the steps (x and y)
    for i in range(4):
        if nums[i] is not None and nums[i+1] is not None:
            diff = nums[i+1] - nums[i]
            if i % 2 == 0:
                x = diff
            else:
                y = diff

    # 3. Handle missing x or y using a 2-step jump logic
    if x is None or y is None:
        for i in range(3):
            if nums[i] is not None and nums[i+2] is not None:
                total = nums[i+2] - nums[i]
                if x is not None:
                    y = total - x
                elif y is not None:
                    x = total - y
                else:
                    x = y = total // 2

        # If still missing one, the pattern is likely constant
        if x is None: x = y
        if y is None: y = x

    # 4. Find the '?' index and fill it
    idx = nums.index(None)

    if idx == 0:
        nums[0] = nums[1] - x
    else:
        # Determine if we need the x step or y step based on the gap index
        step = x if (idx - 1) % 2 == 0 else y
        nums[idx] = nums[idx - 1] + step

    return chr(int(nums[idx]) + ord('a') - 1)

class TestMissingChar(unittest.TestCase):
    def test_cases(self):
        examples = [
            {"in": ["a", "c", "?", "g", "i"], "out": "e"},
            {"in": ["a", "d", "?", "j", "m"], "out": "g"},
            {"in": ["a", "e", "?", "m", "q"], "out": "i"},
            {"in": ["a", "c", "f", "?", "k"], "out": "h"},
            {"in": ["b", "e", "g", "?", "l"], "out": "j"},
        ]
        for ex in examples:
            self.assertEqual(missing_character(ex["in"]), ex["out"])

if __name__ == "__main__":
    unittest.main()
