#!/usr/bin/env python

# Challenge 011
#
# Challenge #1
# Write a script that computes the equal point in the Fahrenheit and Celsius
# scales, knowing that the freezing point of water is 32oF and 0oC, and that
# the boiling point of water is 212oF and 100oC. This challenge was proposed
# by Laurent Rosenfeld.
#
# F = (C * 9/5) + 32
# F = C = x
# =>    x = (x * 9/5) + 32
# <=>   x * (1 - 9/5) = 32
# <=>   x = 32 / (1 - 9/5)

print(32 / (1 - 9/5))
