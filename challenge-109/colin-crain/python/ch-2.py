#!/usr/bin/env python3
#
#
#       four-sq-permute.py
#
#         TASK #2 › Four Squares Puzzle
#         Submitted by: Mohammad S Anwar
#         You are given four squares as below with numbers named a,b,c,d,e,f,g.
# 
#                       (1)                    (3)
#                 ╔══════════════╗      ╔══════════════╗
#                 ║              ║      ║              ║
#                 ║      a       ║      ║      e       ║
#                 ║              ║ (2)  ║              ║  (4)
#                 ║          ┌───╫──────╫───┐      ┌───╫─────────┐
#                 ║          │   ║      ║   │      │   ║         │
#                 ║          │ b ║      ║ d │      │ f ║         │
#                 ║          │   ║      ║   │      │   ║         │
#                 ║          │   ║      ║   │      │   ║         │
#                 ╚══════════╪═══╝      ╚═══╪══════╪═══╝         │
#                            │       c      │      │      g      │
#                            │              │      │             │
#                            │              │      │             │
#                            └──────────────┘      └─────────────┘
#         Write a script to place the given unique numbers in the square box so that sum of numbers in each box is the same.
# 
#         Example
#         Input: 1,2,3,4,5,6,7
# 
#         Output:
# 
#             a = 6
#             b = 4
#             c = 1
#             d = 5
#             e = 2
#             f = 3
#             g = 7
# 
#             Box 1: a + b = 6 + 4 = 10
#             Box 2: b + c + d = 4 + 1 + 5 = 10
#             Box 3: d + e + f = 5 + 2 + 3 = 10
#             Box 4: f + g = 3 + 7 = 10
# 
# 
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##


from itertools import permutations



def find_solutions ( lst ):
    out = []
    for candidate in list( permutations(lst) ):
        (v, n) = validate( candidate )
        if v: 
            out.append( [candidate, n] )
    return out

def validate ( lst ):
    n = lst[0] + lst[1]
    return ( (n == lst[1] + lst[2] + lst[3] 
                == lst[3] + lst[4] + lst[5] 
                == lst[5] + lst[6]), n )

def report ( tup ):
    (list, n) = tup
    
    print(f'''
    ===============================
    solution    
        sum is {n}
        values:
    ''')

    letter_values = zip( ['a','b','c','d','e','f','g'] , list )
    for lv in letter_values:
        print(f"\t\t{lv[0]} = {lv[1]}")
        
    print(f'''
    ===============================
    ''')

input    = [1,2,3,4,5,6,7]
solution = find_solutions(input)
if len(solution) > 0:
    for sol in solution:
        report(sol)
