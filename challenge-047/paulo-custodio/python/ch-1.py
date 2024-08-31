#!/usr/bin/env perl

# Challenge 047
#
# TASK #1
# Roman Calculator
# Write a script that accepts two roman numbers and operation. It should then
# perform the operation on the give roman numbers and print the result.
#
# For example,
#
# perl ch-1.pl V + VI
# It should print
#
# XI

import roman
import sys

if len(sys.argv) != 4:
    print("Usage: ch-1.py xxx +- xxx")
elif sys.argv[2] == "+":
    print(roman.toRoman(roman.fromRoman(sys.argv[1])+roman.fromRoman(sys.argv[3])))
elif sys.argv[2] == "-":
    print(roman.toRoman(roman.fromRoman(sys.argv[1])-roman.fromRoman(sys.argv[3])))
else:
    print("Usage: ch-1.py xxx +- xxx")
