#!/usr/bin/env python3

# Challenge 036
#
# TASK #2
# Write a program to solve Knapsack Problem.
# There are 5 color coded boxes with varying weights and amounts in GBP. Which
# boxes should be choosen to maximize the amount of money while still keeping
# the overall weight under or equal to 15 kgs?
#
# R: (weight = 1 kg, amount = 1)
# B: (weight = 1 kg, amount = 2)
# G: (weight = 2 kg, amount = 2)
# Y: (weight = 12 kg, amount = 4)
# P: (weight = 4 kg, amount = 10)
# Bonus task, what if you were allowed to pick only 2 boxes or 3 boxes or
# 4 boxes? Find out which combination of boxes is the most optimal?

from itertools import combinations

max_weigth = 15

class Box:
    def __init__(self, color, weight, amount):
        self.color = color
        self.weight = weight
        self.amount = amount
    def __repr__(self):
        return "Box("+ \
            ",".join([str(x) for x in \
                       [self.color, self.weight, self.amount]])+ \
            ")"

boxes = [
    Box('R', 1,  1 ),
    Box('B', 1,  2 ),
    Box('G', 2,  2 ),
    Box('Y', 12, 4 ),
    Box('P', 4,  10 )
]

def solve(boxes):
    max_amount = 0
    max_combo = []

    for k in range(1, len(boxes)+1):
        for combo in list(combinations(boxes, k)):
            weight = sum([x.weight for x in list(combo)])
            amount = sum([x.amount for x in list(combo)])
            if weight <= max_weigth:
                if amount > max_amount:
                    max_amount = amount
                    max_combo = list(combo)
    return max_combo

print("".join(sorted([x.color for x in solve(boxes)])))
