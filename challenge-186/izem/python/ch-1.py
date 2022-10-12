"""Perl weekly challenge 186 - Task 1: Zip List.

https://theweeklychallenge.org/blog/perl-weekly-challenge-186/

Please note, name of function ("zip") shadows built-in function.
"""


def zip(list_a: list, list_b: list) -> list:
    """Merge the 2 given list (of same size) interlaced."""
    output = []
    for i in range(len(list_a)):
        output.extend([list_a[i], list_b[i]])

    return output
