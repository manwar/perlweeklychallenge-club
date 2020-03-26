#!/usr/bin/env python

from itertools import permutations


class VowelString:

    def check_valid(self, permutation):

        ok_rules = ['ae', 'ai', 'ei', 'ia', 'ie',
                    'io', 'iu', 'oa', 'ou', 'uo', 'ue']

        for x, item in enumerate(permutation[:-1]):
            if item + permutation[x+1] not in ok_rules:
                return 0

            return 1

    def get_permutations(self,  count: int):

        wovels = ['a', 'e', 'i', 'o', 'u']

        result = []

        for perm in permutations(wovels, count):
            if self.check_valid(perm):
                result.append(perm)

        return(result)


class TestVowelString:

    def __init__(self):
        self.vow = VowelString()

    def do_tests(self):
        assert len(self.vow.get_permutations(1)) == 0
        assert len(self.vow.get_permutations(2)) == 11


if __name__ == "__main__":
    vowcomb = VowelString()

    print(vowcomb.get_permutations(2))

    vowtester = TestVowelString()
    vowtester.do_tests()
