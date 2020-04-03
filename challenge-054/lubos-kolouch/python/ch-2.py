#!/usr/bin/env python
""" PerlWeeklyChallenge 054 Task 2"""


class Collatz:
    """ Collatz Conjecture """

    def __init__(self):
        self.length_cache = dict()

    def get_next_sequence(self, seq_pos: int):
        """ Calculate next position number """

        if seq_pos % 2 == 0:
            return seq_pos // 2

        return 3 * seq_pos + 1

    def single_sequence(self, seq_pos: int):
        """ For the first task, it is easier to separate to own function """
        seq = []
        while seq_pos > 1:

            seq.append(seq_pos)
            seq_pos = self.get_next_sequence(seq_pos)

        seq.append(1)
        return seq

    def get_sequence_length(self, seq_pos: int):
        """ Calculate the sequence """

        if seq_pos == 1:
            # special case
            self.length_cache[1] = 1
            return 1

        seq_length = 0

        cur_pos = seq_pos

        while cur_pos >= 1:

            if self.length_cache.get(cur_pos):
                # If we have already the length cached, return it """
                seq_length += self.length_cache[cur_pos]
                break

            # otherwise increse the length and move to next step
            seq_length += 1
            cur_pos = self.get_next_sequence(cur_pos)

        self.length_cache[seq_pos] = seq_length

        return seq_length

class TestCollatz:
    """Test for the NthPermut class"""

    def do_tests(self):
        """Run the tests"""
        collatz = Collatz()
        assert collatz.single_sequence(1) == [1]
        assert collatz.single_sequence(23) == [23, 70, 35, 106, 53, 160, 80, 40, 20, 10, 5, 16, 8, 4, 2, 1]


def main():
    """Main method"""

#    assert len(sys.argv) == 3

    collatz = Collatz()
    print(collatz.single_sequence(23))

    for seq_pos in range(1, 1_000_001):
        collatz.get_sequence_length(seq_pos)

    print(sorted(collatz.length_cache.items(),
                 key=lambda x: x[1], reverse=True)[:20])

    tester = TestCollatz()
    tester.do_tests()


if __name__ == "__main__":
    main()
