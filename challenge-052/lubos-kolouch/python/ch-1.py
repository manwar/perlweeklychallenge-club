#!python

import sys


def is_stepping(number: str):

    number = str(number)
    seq = str(number)[0]

    for i in number[1:]:
        if abs(int(i)-int(seq)) != 1:
            return 0
        seq = i

    return 1


assert len(sys.argv) == 3

for i in range(int(sys.argv[1]), int(sys.argv[2])+1):
    if is_stepping(i):
        print(i)


# TESTS

assert is_stepping(100) == 0
assert is_stepping(123) == 1
assert is_stepping(321) == 1
assert is_stepping(989) == 1
