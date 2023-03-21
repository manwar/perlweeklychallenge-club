#!/usr/bin/env python
# -*- coding: utf-8 -*-
import unittest
from typing import List, Tuple


def merge_email_lists(
        accounts: List[Tuple[str, List[str]]]) -> List[Tuple[str, List[str]]]:
    merged_lists = []

    for account in accounts:
        list_name, emails = account
        list_found = False

        for merged_list in merged_lists:
            merged_name, merged_emails = merged_list

            # If the list names match and they share a common email address, merge the lists
            if list_name == merged_name and any(email in emails
                                                for email in merged_emails):
                merged_list[1].extend(emails)
                list_found = True
                break

        # If the list name is not found in the merged lists, add the current list
        if not list_found:
            merged_lists.append([list_name, emails])

    # Remove duplicate email addresses from each list and sort them
    for merged_list in merged_lists:
        merged_list[1] = sorted(set(merged_list[1]))

    return merged_lists


class TestMergeEmailLists(unittest.TestCase):

    def test_merge_email_lists(self):
        test_accounts = [
            ("A", ["a1@a.com", "a2@a.com"]),
            ("B", ["b1@b.com"]),
            ("A", ["a3@a.com"]),
            ("B", ["b2@b.com", "b1@b.com"]),
        ]

        expected_email_lists = [
            ["A", ["a1@a.com", "a2@a.com"]],
            ["B", ["b1@b.com", "b2@b.com"]],
            ["A", ["a3@a.com"]],
        ]

        self.assertEqual(merge_email_lists(test_accounts),
                         expected_email_lists)


if __name__ == "__main__":
    unittest.main()
