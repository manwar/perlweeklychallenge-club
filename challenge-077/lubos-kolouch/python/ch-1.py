#!/bin/env python
""" Perl Weekly challenge 077 Task 1
    https://perlweeklychallenge.org/blog/perl-weekly-challenge-077/
    Solution Lubos Kolouch """


class FibSolver:
    """ Class for solving the challenge """

    def __init__(self, n: int):
        """ init the solution """
        self.max_n = n
        self.solution_arr = list()
        self.all_fibs = list()

    def get_all_fibs(self):
        """ Generate all fibonacci numbers """

        self.all_fibs.append(2)
        self.all_fibs.append(1)

        fib_nr = 2

        while fib_nr < self.max_n:
            fib_nr = self.all_fibs[0] + self.all_fibs[1]
            self.all_fibs.insert(0, fib_nr)

    def find_solutions(self):
        """ Print all solutions """

        self.get_all_fibs()
        self.partition(solution=[])

        if self.solution_arr:
            print(self.solution_arr)
            return self.solution_arr

        print("0")
        return 0

    def partition(self, idx: int = 0, solution: list = None):
        """ Recursive method to get the partitions """

        rem_value = self.max_n - sum(solution)
        if rem_value == 0:
            self.solution_arr.append(solution)
            return

        for i in range(idx, len(self.all_fibs)):
            if self.all_fibs[i] > rem_value:
                continue
            self.partition(i+1, solution+[self.all_fibs[i]])
        return


fib = FibSolver(-19)
assert fib.find_solutions() == 0
fib = FibSolver(6)
assert fib.find_solutions() == [[5, 1], [3, 2, 1]]
fib = FibSolver(9)
assert fib.find_solutions() == [[8, 1], [5, 3, 1]]
