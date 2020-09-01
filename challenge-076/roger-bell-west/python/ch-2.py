#! /usr/bin/python3

import argparse
import sys

minlen=5
grid=list()
searchspaces=list()
y=0

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('puzzle', type=argparse.FileType('r'),
                    help='the puzzle file')
parser.add_argument('wordlist', type=argparse.FileType('r'),
                    help='the wordlist file')
args = parser.parse_args()

for lino, line in enumerate(args.puzzle, start=1):
    q=line.rstrip().lower().split()
    if (y>0):
        if (y != len(q)):
            sys.exit("Not a rectangular grid")
    else:
        y=len(q)
    grid.append(q)
    searchspaces.append(''.join(q))
    searchspaces.append(''.join(reversed(q)))
x=len(grid)

for i in range(0,y):
    q=[grid[j][i] for j in range(0,x)]
    searchspaces.append(''.join(q))
    searchspaces.append(''.join(reversed(q)))

mxy=max(x,y)
for xi in range(-y+minlen-1,x-minlen+1):
    seq=[[xi+i,i] for i in range(0,mxy) if xi+i>=0 and xi+i<x and i<y]
    if (len(seq) >= minlen):
        q=[grid[i[0]][i[1]] for i in seq]
        searchspaces.append(''.join(q))
        searchspaces.append(''.join(reversed(q)))
for xi in range(-y+minlen-1,x-minlen+1):
    seq=[[xi+i,y-i] for i in range(1,mxy) if xi+i>=0 and y-i>=0 and xi+i<x]
    if (len(seq) >= minlen):
        q=[grid[i[0]][i[1]] for i in seq]
        searchspaces.append(''.join(q))
        searchspaces.append(''.join(reversed(q)))

found=list()

for lino, line in enumerate(args.wordlist, start=1):
    w=line.rstrip().lower()
    if (len(w) >= minlen):
        for ss in searchspaces:
            if (w in ss):
                found.append(w)
                break

found.sort()
print(', '.join(found))
