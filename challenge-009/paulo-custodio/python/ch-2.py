#!/usr/bin/python3

# Challenge 009
#
# Challenge #2
# Write a script to perform different types of ranking as described below:
#
# 1. Standard Ranking (1224): Items that compare equal receive the same ranking
#    number, and then a gap is left in the ranking numbers.
# 2. Modified Ranking (1334): It is done by leaving the gaps in the ranking
#    numbers before the sets of equal-ranking items.
# 3. Dense Ranking    (1223): Items that compare equally receive the same
#    ranking number, and the next item(s) receive the immediately following
#    ranking number.

import sys
import operator

class Item():
    def __init__(self, index, value):
        self.index = index
        self.value = value
        self.rank = 0

    def __str__(self):
        return f"Item(index={self.index},value={self.value},rank={self.rank})"

class Items():
    def __init__(self, values):
        self.items = []
        for index, value in enumerate(values):
            self.items.append(Item(index, value))

    def __str__(self):
        return "["+ ", ".join([str(x) for x in self.items]) +"]"

    def elems(self):
        return self.items

    def sort_by_value(self):
        self.items = sorted(self.items, key=operator.attrgetter('value'))[::-1]

    def sort_by_index(self):
        self.items = sorted(self.items, key=operator.attrgetter('index'))

    def count_same(self, i):
        value = self.items[i].value
        count = 0
        while i < len(self.items) and self.items[i].value == value:
            count += 1
            i += 1
        return count

    def standard_ranking(self):
        self.sort_by_value()
        rank = 1
        i = 0
        while i < len(self.items):
            same = self.count_same(i)
            for j in range(i, i+same):
                self.items[j].rank = rank
            rank += same
            i += same
        self.sort_by_index()

    def modified_ranking(self):
        self.sort_by_value()
        rank = 1
        i = 0
        while i < len(self.items):
            same = self.count_same(i)
            for j in range(i, i+same):
                self.items[j].rank = rank+same-1
            rank += same
            i += same
        self.sort_by_index()

    def dense_ranking(self):
        self.sort_by_value()
        rank = 1
        i = 0
        while i < len(self.items):
            same = self.count_same(i)
            for j in range(i, i+same):
                self.items[j].rank = rank
            rank += 1
            i += same
        self.sort_by_index()

items = Items([int(x) for x in sys.argv[1:]])
print("Data:             "+", ".join([str(x.value) for x in items.elems()]))
items.standard_ranking()
print("Standard ranking: "+", ".join([str(x.rank) for x in items.elems()]))
items.modified_ranking()
print("Modified ranking: "+", ".join([str(x.rank) for x in items.elems()]))
items.dense_ranking()
print("Dense ranking:    "+", ".join([str(x.rank) for x in items.elems()]))
