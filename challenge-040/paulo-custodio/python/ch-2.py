#!/usr/bin/env python3

# Challenge 040
#
# TASK #2
# Sort SubList
# You are given a list of numbers and set of indices belong to the list.
# Write a script to sort the values belongs to the indices.
#
# For example,
#
# List: [ 10, 4, 1, 8, 12, 3 ]
# Indices: 0,2,5
# We would sort the values at indices 0, 2 and 5 i.e. 10, 1 and 3.
#
# Final List would look like below:
#
# List: [ 1, 4, 3, 8, 12, 10 ]

data = [10, 4, 1, 8, 12, 3]
indices = [0,2,5]

def sort_sublist(data, indices):
    values = []
    for i in indices:
        values.append(data[i])
    values.sort()
    for i in indices:
        data[i] = values.pop(0)
    return data

data = sort_sublist(data, indices)
print("["+(", ".join([str(x) for x in data]))+"]")
