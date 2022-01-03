#!/usr/bin/python3
# ch-1.py

# > https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
#
#  ## Task2 > Palindromic Tree
#  ===========================
#
#  You are given a string `$s`.
#
#  Write a script to create a `Palindromic Tree` for the given string
#
#  I found this [blog] explaining `Palindromic Tree` in detail.
#
#  **Example 1:**
#
#  ```
#  Input: $s = 'redivider'
#  Output: r redivider e edivide d divid i ivi v
#  ```
#
#  **Example 2:**
#
#  ```
#  Input: $s = 'deific'
#  Output: d e i ifi f c
#  ```
#
#  **Example 3:**
#
#  ```
#  Input: $s = 'rotors'
#  Output: r rotor o oto t s
#  ```
#
#  **Example 4:**
#
#  ```
#  Input: $s = 'challenge'
#  Output: c h a l ll e n g
#  ```
#
#  **Example 5:**
#
#  ```
#  Input: $s = 'champion'
#  Output: c h a m p i o n
#  ```
#
#  **Example 6**
#
#  ```
#  Input: $s = 'christmas'
#  Output: c h r i s t m a
#  ```
#
#  [blog]: https://medium.com/@alessiopiergiacomi/eertree-or-palindromic-tree-82453e75025b

import sys
from pathlib import Path

###############################################################################
# PWC Solution ################################################################
###############################################################################


def is_palindrome(string=''):
    gnirts = string[::-1]
    return gnirts == string


def eertree(string):
    palindromes = []
    length = len(string)
    for cursor in range(length):
        for i in range(cursor, length):
            chars = i + 1
            substring = string[cursor:chars]
            if substring not in palindromes and is_palindrome(substring):
                palindromes.append(substring)
    return ' '.join(palindromes)


###############################################################################
# Utilities ###################################################################
###############################################################################


def parse_test_case(filepath):
    with open(filepath) as f:
        lines = f.read().splitlines()
        filtered = list(filter(lambda l: not l.strip().startswith('#'), lines))
        string, test = filtered
        return [string.strip(), test.strip()]


def print_params(path, string, test):
    print(f"{path}:")
    print(f"Input: $s = {string}")
    print(f"Output: {test}")


def test_solution(solution, string, test):
    result = solution(string)
    if test == result:
        print("\u001b[32mPassed \u2690\u001b[0m\n")
        return True
    else:
        print("\u001b[31mFailed \u2715\u001b[0m\n")
        return False


def print_and_run(target):
    string, test = parse_test_case(target)
    print_params(target, string, test)
    test_solution(eertree, string, test)


def run_test_suite(directory):
    for child in Path(directory).iterdir():
        if child.is_file():
            print_and_run(child)


###############################################################################
# Main ########################################################################
###############################################################################


try:
    target = sys.argv[1]
except IndexError:
    target = '../test_cases/ch-2/'

path = Path(target)

if path.is_file():
    print_and_run(target)
elif path.is_dir():
    run_test_suite(target)
else:
    print(f"No tests found at: {target}")
