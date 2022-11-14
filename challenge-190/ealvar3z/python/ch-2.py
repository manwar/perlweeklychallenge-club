#!/usr/bin/env python3
from __future__ import annotations
from unittest import main, TestCase
from typing import List


def runner(start: str, i: int, arg: str, result: List[str]) -> None:
    l = len(arg)
    if i == l:
        result.append(start)
        return
    nums = [int(arg[i])]

    if i + 1 < l:
        nums.append(int(arg[i] + arg[i+1]))

    diff = 1
    for n in nums:
        if 1 <= n and n <= 26:
            c = chr(ord('A') + n - 1)
            runner(start + c, i + diff, arg, result)
        diff += 1


def decode(arg: str) -> List[str]:
    result = []
    runner("", 0, arg, result)
    return result


class TestDecodeList(TestCase):


    def test_example_one(self):
        self.assertEqual(decode("11"), ["AA", "K"], 'Example 1')


    def test_example_two(self):
        self.assertEqual(decode("1115"), ["AAAE", "AAAO", "AKE", "KAE", "KO"], 'Example 2')


    def test_example_three(self):
        self.assertEqual(decode("127"), ["ABG", "LG"], 'Example 3')


if __name__ == "__main__":
   main(verbosity=2) 
