#!/usr/bin/python3

# Challenge 034
#
# Task #1
# Contributed by Dave Cross
# Write a program that demonstrates using hash slices and/or array slices.

data = {'oranges':3, 'pears':2, 'apples':4}
values = [data[x] for x in 'oranges apples'.split()]
print(*values, sep=", ")
