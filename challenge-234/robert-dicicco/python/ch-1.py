#!/usr/bin/env python
'''
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-13
Challenge 234 Task 1 Common Characters ( Python )
------------------------------------------------
'''

wordlist = [["java", "javascript", "julia"],["bella", "label", "roller"],["cool", "lock", "cook"]]

def CreateSeen (w):
    seen = dict()
    charset = "".join(w)
    for x in charset:
        seen[x] = 0
    for x in charset:
        seen[x] += 1

    print("Output: (", end="")
    for key, value in seen.items():
        if value >= 3 and value < 6:
            print(f"{key} ",end="")
        elif value == 6:
            print(f"{key} ", end="")
            print(f"{key} ", end="")
    print(")\n")

for wds in wordlist:
    print("Input: @wordlist = ",wds)
    charset = ""

    wordnum = len(wds)
    CreateSeen(wds)

'''
------------------------------------------------
SAMPLE OUTPUT
python .\CommonCharacters.py

Input: @wordlist =  ['java', 'javascript', 'julia']
Output: (j a )

Input: @wordlist =  ['bella', 'label', 'roller']
Output: (e l l )

Input: @wordlist =  ['cool', 'lock', 'cook']
Output: (c o )
------------------------------------------------
'''



