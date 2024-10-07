### https://theweeklychallenge.org/blog/perl-weekly-challenge-288/
"""

Task 2: Contiguous Block

Submitted by: [50]Peter Campbell Smith
     __________________________________________________________________

   You are given a rectangular matrix where all the cells contain either x
   or o.

   Write a script to determine the size of the largest contiguous block.

     A contiguous block consists of elements containing the same symbol
     which share an edge (not just a corner) with other elements in the
     block, and where there is a path between any two of these elements
     that crosses only those shared edges.

Example 1

    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'o', 'o'],
                     ]
    Ouput: 11

        There is a block of 9 contiguous cells containing 'x'.
        There is a block of 11 contiguous cells containing 'o'.

Example 2

    Input: $matrix = [
                       ['x', 'x', 'x', 'x', 'x'],
                       ['x', 'o', 'o', 'o', 'o'],
                       ['x', 'x', 'x', 'x', 'o'],
                       ['x', 'o', 'o', 'o', 'o'],
                     ]
    Ouput: 11

        There is a block of 11 contiguous cells containing 'x'.
        There is a block of 9 contiguous cells containing 'o'.

Example 3

    Input: $matrix = [
                       ['x', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                       ['o', 'x', 'x', 'o', 'o'],
                       ['o', 'o', 'o', 'x', 'x'],
                     ]
    Ouput: 7

        There is a block of 7 contiguous cells containing 'o'.
        There are two other 2-cell blocks of 'o'.
        There are three 2-cell blocks of 'x' and one 3-cell.
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 29th September
   2024.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
"""
### solution by pokgopun@gmail.com

from typing import TypeAlias, Tuple, List
from dataclasses import dataclass

Row: TypeAlias = Tuple[str]

@dataclass
class Position:
    r: int
    c: int
    def __hash__(self):
        return hash((self.r,self.c))
    def __eq__(self,other):
        return (self.r,self.c) == (other.r,other.c)
    def __ne__(self,other):
        return not(self==other)

@dataclass
class Block:
    mark: str
    positions: List[Position]

class Blocks:
    def __init__(self, matrix: Tuple[Row]):
        self.vals: List[Block] = []
        self.largest = 0
        self.pos2mark: Dict[Position,str] = dict()
        for r in range(len(matrix)):
            row = matrix[r]
            for c in range(len(row)):
                self.pos2mark[Position(r,c)] = row[c]
        while len(self.pos2mark) > 0:
            pos,mark = self.pos2mark.popitem()
            block = Block(mark,[pos])
            self.largest = max(self.largest, self.process(block, pos, 1))
            self.vals.append(block)
        #print(self.vals)
    def process(self,block: Block,pos: Position, cnt: int) -> int:
        for o in ((0,1),(1,0),(-1,0),(0,-1)):
            p = Position(pos.r+o[0],pos.c+o[1])
            if self.pos2mark.get(p) == block.mark:
                self.pos2mark.pop(p)
                block.positions.append(p)
                cnt += self.process(block,p,1)
        return cnt

import unittest

class TestContigiousBlock(unittest.TestCase):
    def test(self):
        for inpt, otpt in {
                (
                    ('x', 'x', 'x', 'x', 'o'),
                    ('x', 'o', 'o', 'o', 'o'),
                    ('x', 'o', 'o', 'o', 'o'),
                    ('x', 'x', 'x', 'o', 'o'),
                    ): 11,
                (
                    ('x', 'x', 'x', 'x', 'x'),
                    ('x', 'o', 'o', 'o', 'o'),
                    ('x', 'x', 'x', 'x', 'o'),
                    ('x', 'o', 'o', 'o', 'o'),
                    ): 11,
                (
                    ('x', 'x', 'x', 'o', 'o'),
                    ('o', 'o', 'o', 'x', 'x'),
                    ('o', 'x', 'x', 'o', 'o'),
                    ('o', 'o', 'o', 'x', 'x'),
                    ): 7,
                }.items():
            #print(inpt,otpt)
            self.assertEqual(Blocks(inpt).largest,otpt)

unittest.main()
