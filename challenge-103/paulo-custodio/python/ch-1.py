#!/usr/bin/env python

# Challenge 103
# 
# TASK #1 > Chinese Zodiac
# Submitted by: Mohammad S Anwar
# You are given a year $year.
# 
# Write a script to determine the Chinese Zodiac for the given year $year. 
# Please check out wikipage for more information about it.
# 
# The animal cycle: Rat, Ox, Tiger, Rabbit, Dragon, Snake, Horse, Goat, Monkey,
# Rooster, Dog, Pig.
# The element cycle: Wood, Fire, Earth, Metal, Water.
# 
# Example 1:
#     Input: 2017
#     Output: Fire Rooster
# Example 2:
#     Input: 1938
#     Output: Earth Tiger

import sys;

animals = ['Rat','Ox','Tiger','Rabbit','Dragon','Snake','Horse','Goat',
		   'Monkey','Rooster','Dog','Pig']
elements = ['Wood','Wood','Fire','Fire','Earth','Earth','Metal','Metal',
			'Water','Water'];

year = int(sys.argv[1])
num_years = year-1924;
element = num_years % len(elements);
animal = num_years % len(animals);

print(elements[element]," ",animals[animal]);
