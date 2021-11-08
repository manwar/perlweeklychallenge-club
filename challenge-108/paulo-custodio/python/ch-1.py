#!/usr/bin/env python3

# Challenge 108
#
# TASK #1 - Locate Memory
# Submitted by: Mohammad S Anwar
#
# Write a script to declare a variable or constant and print it's location in
# the memory.

var = "hello world"
print(hex(id(var)))
