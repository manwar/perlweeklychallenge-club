#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Define an array of numbers
numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

# Print the first three elements of the array using a slice
print(f"First three elements: {numbers[:3]}")

# Print the last five elements of the array using a slice
print(f"Last five elements: {numbers[-5:]}")

# Define a dictionary of ages
ages = {"Alice": 27, "Bob": 31, "Charlie": 32, "Dave": 29, "Emily": 24}

# Define a list of names
names = ["Alice", "Charlie", "Emily"]

# Use a hash slice to print the ages of Alice, Charlie, and Emily
print(f"Ages: {[ages[name] for name in names]}")
