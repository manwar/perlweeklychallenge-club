#!/usr/bin/env python3

# Challenge 043
#
# TASK #1
# Olympic Rings
# There are 5 rings in the Olympic Logo as shown below. They are color coded as
# in Blue, Black, Red, Yellow and Green.
#
# Olympic Rings
#
# We have allocated some numbers to these rings as below:
#
# Blue: 8
# Yellow: 7
# Green: 5
# Red: 9
# The Black ring is empty currently. You are given the numbers 1, 2, 3, 4 and 6.
# Write a script to place these numbers in the rings so that the sum of numbers
# in each ring is exactly 11.

total = 11

red = 9
red_green = total-red

green = 5
green_black = total-green-red_green

blue = 8
blue_yellow = total-blue

yellow = 7
yellow_black = total-yellow-blue_yellow

black = total-green_black-yellow_black

assert red+red_green==total
assert red_green+green+green_black==total
assert green_black+black+yellow_black==total
assert yellow_black+yellow+blue_yellow==total
assert blue_yellow+blue==total

print(f"{red} {red_green} {green} {green_black} {black} {yellow_black} {yellow} {blue_yellow} {blue}")
