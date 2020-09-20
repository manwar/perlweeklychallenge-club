# Task 2 from
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
#
# Comments: https://andrewshitov.com/2020/09/14/the-weekly-challenge-078/
#
# Output:
#
# [40, 50, 10, 20, 30]
# [50, 10, 20, 30, 40]

from collections import deque

a = [10, 20, 30, 40, 50]
b = [3, 4]

for x in b:
    d = deque(a)
    d.rotate(-x)
    print(list(d))
