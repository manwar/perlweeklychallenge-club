#!/usr/bin/env python
# -*- coding: utf-8 -*-

def transpose_file(filename):
    with open(filename, 'r') as f:
        lines = f.readlines()

    # Split each line into a list of fields
    lines = [line.strip().split(',') for line in lines]

    # Use zip() to transpose rows to columns
    transposed = zip(*lines)

    # Join the fields back together and write to a new file
    with open('transposed_' + filename, 'w') as f:
        for row in transposed:
            f.write(','.join(row))
            f.write('\n')


transpose_file('input.txt')
