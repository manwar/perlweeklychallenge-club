#!/usr/bin/env python3

# Challenge 110
#
# TASK #2 - Transpose File
# Submitted by: Mohammad S Anwar
# You are given a text file.
#
# Write a script to transpose the contents of the given file.
#
# Input File
# name,age,sex
# Mohammad,45,m
# Joe,20,m
# Julie,35,f
# Cristina,10,f
# Output:
# name,Mohammad,Joe,Julie,Cristina
# age,45,20,35,10
# sex,m,m,f,f

import fileinput
import sys

def read_input():
    lines = []
    for line in fileinput.input():
        lines.append(line)
    return lines

def read_data(lines):
    m = []
    for line in lines:
        line = line.strip()
        cols = line.split(',')
        m.append(cols)
    return m

def transpose(m):
    t = [[m[j][i] for j in range(len(m))] for i in range(len(m[0]))]
    return t

def print_data(m):
    for row in m:
        print(",".join(row))

print_data(transpose(read_data(read_input())))
