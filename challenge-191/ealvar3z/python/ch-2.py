#!/usr/bin/env python3
import unittest


class TestSolutionII(unittest.TestCase):

    def cute_list(self, n):
        bitset_total = 2**n
        bitset = [[0 for i in range(bitset_total)] for j in range(n+1)]
        # set the base case
        bitset[0][0] = 1

        # iterate over all of the positions
        for i in range(1, n+1):
            # iterate over all of the subsets
            for j in range(bitset_total):
                # iterate over all of the numbers w/in each subset
                for k in range(n):
                    # for each number in the subset
                    # check if the number exists?
                    visit = (j & (1 << k))  # is the bit set?
                    condition_one_holds = ((k+1) % i == 0)
                    condition_two_holds = (i % (k+1) == 0)
                    if visit and condition_one_holds or condition_two_holds:
                        # if one of these conditions hold, and we have seen the
                        # value, then the list is cute.
                        # Grab the count of what we've seen and return it.
                        # if this bit was set, unset it
                        visited = (j ^ (1 << k))
                        saw_it = bitset[i-1][visited]
                        count = bitset[i][j] = bitset[i][j] + saw_it
        return count

    def test_cute_list(self):
        self.assertEqual(self.cute_list(2), 2)


if __name__ == "__main__":
    unittest.main(verbosity=True)
