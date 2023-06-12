#!/usr/bin/env python
# -*- coding: utf-8 -*-

def find_missing_row(filename):
    with open(filename, 'r') as file:
        rows = [int(line.split(',')[0]) for line in file]
    return set(range(1, 16)).difference(rows).pop()


# Test case: assuming the file is named 'file.txt'
print(find_missing_row('file.txt'))  # Should print the missing line number
