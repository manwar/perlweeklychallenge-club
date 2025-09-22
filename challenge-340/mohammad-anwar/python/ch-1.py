#!/usr/bin/env python3

import unittest

def remove_duplicates(s: str) -> str:
    if len(s) < 2:
        return s

    for i in range(len(s) - 1):
        if s[i] == s[i + 1]:
            new_str = s[:i] + s[i + 2:]
            return remove_duplicates(new_str)

    return s

class TestRemoveDuplicates(unittest.TestCase):
    def test_examples(self):
        examples = {
            1: {'str': 'abbaca',   'exp': 'ca'},
            2: {'str': 'azxxzy',   'exp': 'ay'},
            3: {'str': 'aaaaaaaa', 'exp': ''},
            4: {'str': 'aabccba',  'exp': 'a'},
            5: {'str': 'abcddcba', 'exp': ''},
        }

        for example_id, example_data in examples.items():
            with self.subTest(example_id=example_id, example_str=example_data['str']):
                result = remove_duplicates(example_data['str'])
                self.assertEqual(result, example_data['exp'])

if __name__ == '__main__':
    unittest.main()
