#!/usr/bin/env python
""" PerlWeeklyChallenge 053"""

from itertools import permutations


class VowelString:
    """ Produce all valid permutations"""

    def __init__(self):
        self.permutation = ''

    def check_valid(self):
        """ Check if given permutation is valid"""

        ok_rules = ['ae', 'ai', 'ei', 'ia', 'ie',
                    'io', 'iu', 'oa', 'ou', 'uo', 'ue']

        for item_count, item in enumerate(self.permutation[:-1]):
            if item + self.permutation[item_count+1] not in ok_rules:
                return 0

            return 1

    def get_permutations(self, count: int):
        """ process all possible permutations"""

        wovels = ['a', 'e', 'i', 'o', 'u']

        result = []

        for perm in permutations(wovels, count):
            self.permutation = perm
            if self.check_valid():
                result.append(perm)

        return result


class TestVowelString:
    """Test for the VowelString method"""

    def __init__(self):
        self.vow = VowelString()

    def do_tests(self):
        """Run the tests"""
        assert len(self.vow.get_permutations(1)) == 0
        assert len(self.vow.get_permutations(2)) == 11


def main():
    """Main method"""

    vowcomb = VowelString()

    print(vowcomb.get_permutations(2))

    vowtester = TestVowelString()
    vowtester.do_tests()


if __name__ == "__main__":
    main()
