#!/usr/local/bin/python3

# You are given an array of integers.
# Write a script to create an array such that new[i] = old[old[i]] where 0 <= i < new.length.

def create_new_array (ints):
    new_ints = []
    # Loop through old array to create new array
    for i, item in enumerate(ints):
        new_ints.insert(i, ints[ints[i]])
    print(new_ints)

# Example 1
ints = (0, 2, 1, 5, 3, 4)
create_new_array(ints)

# Example 2
ints = (5, 0, 1, 2, 3, 4)
create_new_array(ints)
