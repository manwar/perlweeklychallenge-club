#!/usr/bin/env python3

# Challenge 068
#
# TASK #2 > Reorder List
# Submitted by: Mohammad S Anwar
# You are given a singly linked list $L as below:
#
# L0 ?  L1 ?  ... ?  Ln-1 ?  Ln
# Write a script to reorder list as below:
#
# L0 ?  Ln ?  L1 ?  Ln-1 ?  L2 ?  Ln-2 ?
# You are ONLY allowed to do this in-place without altering the nodes' values.
#
# Example
# Input:  1 ?  2 ?  3 ?  4
# Output: 1 ?  4 ?  2 ?  3

import unittest

def reorder_list(l):
    # get second element
    tail = l[1]
    # get and remove last element
    p = tail
    last = None
    while len(p) > 1:
        last = p
        p = p[1]
    eln = last.pop()

    return [l[0], [eln[0], tail]]

class TestReorderList(unittest.TestCase):
    def test_reorder_list(self):
        self.assertEqual(reorder_list([1, [2, [3, [4]]]]), [1, [4, [2, [3]]]])

if __name__ == '__main__':
    unittest.main()
