#!/usr/bin/env python3

import unittest


def similar_list(list1, list2, list3):
    if len(list1) != len(list2):
        return "false"

    canon = {}
    for group in list3:
        rep = group[0]
        for item in group:
            canon[item] = rep

    for i in range(len(list1)):
        a = canon.get(list1[i], list1[i])
        b = canon.get(list2[i], list2[i])
        if a != b:
            return "false"

    return "true"


class TestSimilarList(unittest.TestCase):

    examples = [
        {
            "in": [
                ["great", "acting"],
                ["fine", "drama"],
                [["great", "fine"], ["acting", "drama"]],
            ],
            "out": "true",
        },
        {
            "in": [
                ["apple", "pie"],
                ["banana", "pie"],
                [["apple", "peach"], ["peach", "banana"]],
            ],
            "out": "false",
        },
        {
            "in": [
                ["perl4", "python"],
                ["raku", "python"],
                [["perl4", "perl5", "raku"]],
            ],
            "out": "true",
        },
        {
            "in": [
                ["enjoy", "challenge"],
                ["love", "weekly", "challenge"],
                [["enjoy", "love"]],
            ],
            "out": "false",
        },
        {
            "in": [
                ["fast", "car"],
                ["quick", "vehicle"],
                [["quick", "fast"], ["vehicle", "car"]],
            ],
            "out": "true",
        },
    ]

    def test_similar_list_cases(self):
        for index, example in enumerate(self.examples):
            with self.subTest(case=index):
                list1, list2, list3 = example["in"]
                expected = example["out"]
                actual = similar_list(list1, list2, list3)

                self.assertEqual(actual, expected)


if __name__ == "__main__":
    unittest.main()
