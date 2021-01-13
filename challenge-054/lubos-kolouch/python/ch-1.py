#!/usr/bin/env python
""" PerlWeeklyChallenge 054"""

import sys
from itertools import permutations


class NthPermut:
    """ Produce nth permutation"""

    def get_nth_permutations(self, n_integers: int, k_permutation: int):
        """ return the nth permutation"""

        nth_perm = list(permutations(range(1, n_integers+1)))[k_permutation-1]

        return nth_perm


class TestNthPermut:
    """Test for the NthPermut class"""

    def __init__(self):
        self.perm = NthPermut()

    def do_tests(self):
        """Run the tests"""
        assert self.perm.get_nth_permutations(3, 4) == (2, 3, 1)


def main():
    """Main method"""

    assert len(sys.argv) == 3

    permutator = NthPermut()

    print(permutator.get_nth_permutations(int(sys.argv[1]), int(sys.argv[2])))

    perm_tester = TestNthPermut()
    perm_tester.do_tests()


if __name__ == "__main__":
    main()
