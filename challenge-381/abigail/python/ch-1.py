#!/opt/homebrew/bin/python3

import sys

matrix = []

for line in sys . stdin:
    matrix . extend ([line . strip () . split (" ")])

N = len (matrix)
r = True

for i in range (N):
    row = {}
    col = {}
    for j in range (N):
        r = r and 1 <= int (matrix [i] [j]) and int (matrix [i] [j]) <= N
        row [matrix [i] [j]] = 1
        col [matrix [j] [i]] = 1
    r = r and len (row) == N and len (col) == N

print ("true" if r else "false")
