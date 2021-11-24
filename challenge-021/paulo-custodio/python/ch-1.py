#!/usr/bin/python3

# Challenge 021
#
# Task #1
# Write a script to calculate the value of e, also known as Euler's number and
# Napier's constant. Please checkout wiki page for more information.

def calc_e():
    e = 1
    n = 0
    prod = 1
    prev = 0
    while prev != e:
        prev = e
        n += 1
        prod *= n
        e += 1/prod

    return e

print("{:.14f}".format(calc_e()))
