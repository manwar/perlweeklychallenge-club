#!/bin/env python
""" https://perlweeklychallenge.org/blog/perl-weekly-challenge-078/
    Task 1
    Leader Element
    19.9.2020 Lubos Kolouch """


class LeaderElements:
    """ Class to find Leader elements from a list """

    def __init__(self, arr: list()):
        self.arr = arr
        self.leaders = list()

    def process_list(self):
        """ Process the list and fill in leaders """

        if not self.arr:
            return 0

        self.leaders.insert(0, self.arr[-1])
        for item in reversed(self.arr):
            if item > self.leaders[0]:
                self.leaders.insert(0, item)

        return 1

    def return_leaders(self):
        """ Return the leaders list """
        return self.leaders


tester = LeaderElements([9, 10, 7, 5, 6, 1])
tester.process_list()
assert tester.return_leaders() == [10, 7, 6, 1]

tester = LeaderElements([3, 4, 5])
tester.process_list()
assert tester.return_leaders() == [5]

tester = LeaderElements([])
tester.process_list()
assert tester.return_leaders() == []
