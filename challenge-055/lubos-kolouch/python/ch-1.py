##!/usr/bin/env python
""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-055/
    Challenge 1 - Flip binary """

from collections import defaultdict
import sys


class BinFlip:
    """ Does the flip according to the excercise """

    def __init__(self, to_flip: str):
        self.to_flip = to_flip
        self.current_flip = ""
        self.all_flips = defaultdict(list)
        self.max_ones = 0
        self.l_count = None
        self.r_count = None

    def process_all_flips(self):
        """ process all possible combinations """

        for l_count in range(len(self.to_flip)):
            for r_count in range(l_count, len(self.to_flip)):
                self.l_count = l_count
                self.r_count = r_count
                self.current_flip = self.do_flip()
                self.process_current()

        return self.max_ones, self.all_flips[self.max_ones]

    def do_flip(self):
        """ do the flip and return the result """

        result = list(self.to_flip)
        for str_pos in range(self.l_count, self.r_count + 1):
            result[str_pos] = "0" if self.to_flip[str_pos] == "1" else "1"

        return ''.join(result)

    def process_current(self):
        """ Process the current flip result """

        ones_count = self.current_flip.count("1")
        self.all_flips[ones_count].append((self.l_count, self.r_count))
        if ones_count > self.max_ones:
            self.max_ones = ones_count


class BinFlipTest:
    """ run the tests """

    def __init__(self):
        self.test_flipper = None

    def test_all(self):
        """ Do the tests """

        self.test_flipper = BinFlip("010")
        max_ones, all_flips = self.test_flipper.process_all_flips()
        assert max_ones == 2
        assert all_flips == [(0, 0), (0, 2), (2, 2)]


def main():
    """ main """
    num_flipper = BinFlip(sys.argv[1])

    max_ones, all_flips = num_flipper.process_all_flips()
    print(f'Max: {max_ones}, l,r: {all_flips}')


if __name__ == "__main__":
    assert len(sys.argv) == 2
    main()
    flip_tester = BinFlipTest()
    flip_tester.test_all()
