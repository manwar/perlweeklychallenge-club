#!/usr/bin/env python3

# Challenge 291
#
# Task 2: Poker Hand Rankings
# Submitted by: Robbie Hatley
# A draw poker hand consists of 5 cards, drawn from a pack of 52: no jokers,
# no wild cards. An ace can rank either high or low.
#
# Write a script to determine the following three things:
#
# 1. How many different 5-card hands can be dealt?
# 2. How many different hands of each of the 10 ranks can be dealt?
#    See here for descriptions of the 10 ranks of Poker hands:
#    https://en.wikipedia.org/wiki/List_of_poker_hands#Hand-ranking_categories
# 3. Check the ten numbers you get in step 2 by adding them together
#    and showing that they're equal to the number you get in step 1.

# see https://brilliant.org/wiki/math-of-poker/

from math import comb
from functools import reduce

# 1. How many different 5-card hands can be dealt?
N = comb(52, 5)
print("N=", N)

# 2. How many different hands of each of the 10 ranks can be dealt?
# high card
n = [0] * 10
n[0] = (comb(13, 5) - 10) * (comb(4, 1) ** 5 - 4)
print("n0=", n[0])

# one pair hand
n[1] = comb(13, 1) * comb(4, 2) * comb(12, 3) * (comb(4, 1) ** 3)
print("n1=", n[1])

# two pair hand
n[2] = comb(13, 2) * (comb(4, 2) ** 2) * comb(11, 1) * comb(4, 1)
print("n2=", n[2])

# three of a kind
n[3] = comb(13, 1) * comb(4, 3) * comb(12, 2) * (comb(4, 1) ** 2)
print("n3=", n[3])

# straight hand
n[4] = comb(10, 1) * (comb(4, 1) ** 5 - 4)
print("n4=", n[4])

# flush hand
n[5] = (comb(13, 5) - 10) * comb(4, 1)
print("n5=", n[5])

# full house hand
n[6] = comb(13, 1) * comb(4, 3) * comb(12, 1) * comb(4, 2)
print("n6=", n[6])

# four of a kind hand
n[7] = comb(13, 1) * comb(4, 4) * comb(12, 1) * comb(4, 1)
print("n7=", n[7])

# straight flush hand
n[8] = comb(10, 1) * comb(4, 1) - 4
print("n8=", n[8])

# royal flush hand
n[9] = 4
print("n9=", n[9])

# 3. Check the ten numbers you get in step 2 by adding them together
#    and showing that they're equal to the number you get in step 1.
assert N == sum(n)
