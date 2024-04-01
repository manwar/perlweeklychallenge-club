# Solution of Task 1 of The Weekly Challenge 263
# https://theweeklychallenge.org/blog/perl-weekly-challenge-263

# $ python3 ch-1.py
# [1, 2]
# []
# [4]

tests = ((1, 5, 3, 2, 4, 2), (1, 2, 4, 3, 5), (5, 3, 2, 4, 2, 1))
values = (2, 6, 4)

def solve(test, value):
    print(
        [i for i, val in enumerate(sorted(test)) if val == value]
    )

for c in range(0, len(tests)):
    solve(tests[c], values[c])

