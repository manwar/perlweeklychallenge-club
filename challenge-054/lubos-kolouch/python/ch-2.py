#!/usr/bin/env python
""" PerlWeeklyChallenge 054 Task 2"""

from functools import lru_cache


class Collatz:
    """ Collatz Conjecture """

    def __init__(self):
        self.length_cache = dict()
        self.seq_cache = dict()

    def get_next_sequence(self, seq_pos: int):
        """ Calculate next position number """

        if seq_pos % 2 == 0:
            return seq_pos // 2

        return 3 * seq_pos + 1

    def get_sequence_length(self, seq_pos: int):
        """ Calculate the sequence """

        """ If we have already the length cached, return it """

        if seq_pos == 1:
            """ special case """
            self.seq_cache[1] = 1
            self.length_cache[1] = 1
            return 1

        seq = []
        seq_length = 0

        cur_pos = seq_pos

#        print(f'---------- {seq_pos} -------')

        while cur_pos >= 1:
    #        print(f'looping {cur_pos} with seq {seq}')

            if self.length_cache.get(cur_pos):
  #              print(self.length_cache)
   #             print(f'getting {cur_pos} from cache')
                seq_length += self.length_cache[cur_pos]
                seq.append(self.seq_cache[cur_pos])
                break

            seq.append(cur_pos)
            seq_length += 1
            cur_pos = self.get_next_sequence(cur_pos)
 #           print(f'next loop : {cur_pos}')

#        print(f'AAA {seq_pos} length {seq_length} seq {seq}')
        self.length_cache[seq_pos] = seq_length
        self.seq_cache[seq_pos] = seq

#        print(self.seq_cache[seq_pos])
        return seq_length

class TestCollatz:
    """Test for the NthPermut class"""

    def do_tests(self):
        """Run the tests"""
        pass


def main():
    """Main method"""

#    assert len(sys.argv) == 3

    collatz = Collatz()
    for seq_pos in range(1,1_000_001):
        collatz.get_sequence_length(seq_pos)
#        print(f'seq {seq_pos} length {collatz.get_sequence_length(seq_pos)}')
#        print(collatz.calculate_sequence.cache_info())

    print(sorted(collatz.length_cache.items(), key = lambda x:x[1], reverse=True)[:20])

if __name__ == "__main__":
    main()
