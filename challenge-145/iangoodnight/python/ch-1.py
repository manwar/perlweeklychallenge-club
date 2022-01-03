#!/usr/bin/python3
# ch-1.py

# > https://theweeklychallenge.org/blog/perl-weekly-challenge-145/
#
# ## Task 1 > Dot Product
# =======================
#
# You are given 2 arrays of the same size, `@a` and `@b`.
#
# Write a script to implement `Dot Product`.
#
# **Example:**
# ```
# @a = (1, 2, 3);
# @b = (4, 5, 6);
#
# $dot_product = (1 * 4) + (2 * 5) + (3 * 6) => 4 + 10 + 18 => 32
# ```

import sys
from pathlib import Path

###############################################################################
# PWC Solution ################################################################
###############################################################################


def dot_product(arr1=[], arr2=[]):
    sum = 0
    for i in range(len(arr1)):
        sum += arr1[i] * arr2[i]
    return sum

###############################################################################
# Utilities ###################################################################
###############################################################################


def nums_from_string(s):
    numstrings = s.split(',')
    return list(map(lambda n: int(n.strip()), numstrings))


def parse_test_case(file_path):
    with open(file_path) as f:
        lines = f.read().splitlines()
        filtered = list(filter(lambda l: not l.strip().startswith('#'), lines))
        a, b, test = filtered
        return [nums_from_string(a), nums_from_string(b), int(test)]


def test_solution(solution, a, b, test):
    result = solution(a, b)
    if test == result:
        print("\u001b[32mPassed \u2690\u001b[0m")
        return True
    else:
        print("\u001b[31mFailed \u2715\u001b[0m")
        return False


def print_params(target, a, b, test):
    print(f"{target}:")
    print("@a = % s" % ', '.join(map(str, a)))
    print("@b = % s" % ', '.join(map(str, b)))
    print(f"Dot Product: {str(test)}")


def print_and_run(target):
    a, b, test = parse_test_case(target)
    print_params(target, a, b, test)
    test_solution(dot_product, a, b, test)
    print()


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
    target = '../test_cases/ch-1/'

path = Path(target)

if path.is_file():
    print_and_run(target)
elif path.is_dir():
    run_test_suite(target)
else:
    print(f"No tests found at: {target}")
