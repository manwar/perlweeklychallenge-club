#!/usr/bin/python3

# Challenge 016
#
# Task #1
# Pythagoras Pie Puzzle, proposed by Jo Christian Oterhals.
#
# At a party a pie is to be shared by 100 guest. The first guest gets 1% of the
# pie, the second guest gets 2% of the remaining pie, the third gets 3% of the
# remaining pie, the fourth gets 4% and so on.
#
# Write a script that figures out which guest gets the largest piece of pie.

import operator

class Slice():
    def __init__(self, guest, slice):
        self.guest = guest
        self.slice = slice
    def __str__(self):
        return f"Slice({self.guest}, {self.slice})"

slices = []
pie = 1
for guest in range(1, 101):
    slice = guest/100*pie
    pie -= slice
    slices.append(Slice(guest, slice))
slices.sort(key=operator.attrgetter('slice'))
slice = slices[-1]

print("Guest {} gets {:.4f}% of the pie.".format(slice.guest, 100*slice.slice))
