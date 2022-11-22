#!/usr/bin/env python3
from collections import Counter, defaultdict
from functools import lru_cache
from unittest import main, TestCase


class TestSolutionII(TestCase):

    # backtracking solution
    def cute(self, n: int) -> int:
        @lru_cache(maxsize=None)
        def backtrack(_list):
            if len(_list) == 1:
                return 1

            count = 0
            for j in range(len(_list)):
                if _list[j] % len(_list) == 0 or len(_list) % _list[j] == 0:
                    count += backtrack(_list[:j] + _list[j+1:])

            return count

        return backtrack(tuple(range(1, n+1)))

    # backtracking, bitmask, & dp solution
    def cuter(self, n: int) -> int:
        num_slots = defaultdict(set)
        for i in range(1, n + 1):
            # For each num, find all its (f)actors and (p)roducts from [1 .. n]
            f = 1
            p = f * f
            factors = i // f
            while p <= i:
                if i % f == 0:
                    num_slots[f].add(i)
                    num_slots[factors].add(i)
                    num_slots[i].add(factors)
                    num_slots[i].add(f)
                f += 1
            num_slots[i].add(i)

        # Get a list of the indices, and count the number of ways we get
        # a unique value from each array.  Sort by length for easier
        # memoization, and reduces "branching".
        values = sorted(num_slots.values(), key=len)

        # Pass values to our helper function to run the counter.
        return self.runner(values)

    @lru_cache(maxsize=None)
    def runner(self, values, start=0, seen={0: 1}):
        # `seen` represents the states so far: Each key is a possible set of
        # numbers that we've already been seen, as a bitmask.  Each value is
        # the # of ways we could have arrived at that set.

        # base case
        if start == len(values):
            return sum(seen.values())

        cache = Counter()

        # For each path we've seen
        for k, v in seen.items():
            # For each available number
            for i in values[start]:
                # if it has not been chosen
                if (1 << i) & k == 0:
                    # grab the count, and add it to the cache
                    cache[k + (1 << i)] += v

        # backtrack
        return self.runner(values, start + 1, cache)

    def test_cute(self):
        self.assertEqual(self.cute(15), 24679)

    def test_cuter(self):
        self.assertEqual(self.cute(15), 24679)


if __name__ == "__main__":
    main(verbosity=True)
