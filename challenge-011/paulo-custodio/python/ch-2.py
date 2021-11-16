#!/usr/bin/python3

# Challenge 011
#
# Challenge #2
# Write a script to create an Indentity Matrix for the given size. For example,
# if the size is 4, then create Identity Matrix 4x4. For more information about
# Indentity Matrix, please read the wiki page.

import sys

def id_matrix(size):
    id = [[0 for y in range(size)] for x in range(size)]
    for i in range(size):
        id[i][i] = 1
    return id

def print_matrix(m):
    output = "["
    sep = ""
    for row in m:
        output += sep+"["+", ".join([str(x) for x in row])+"]"
        sep = ",\n "
    output += "]"
    print(output)

size = int(sys.argv[1])
id = id_matrix(size)
print_matrix(id)
