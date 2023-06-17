#!/usr/bin/env python
# -------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-06-13
# Challenge 221 Task 1 Good Strings ( Python )
# -------------------------------------

total_score = 0

words = [["cat", "bt", "hat", "tree"], ["hello", "world", "challenge"]]
chlist = ["atach","welldonehopper"]
cnt = 0
listcnt = 0

for wds in words:
    print("Input: @words = ",wds)
    chars = chlist[cnt]
    total_score = 0
    score = 0
    for w in wds:
        ln = len(w)
        for mycnt in range(0,ln):
            tst = w[mycnt]
            if tst in chlist[listcnt]:
                score += 1
            else:
                break
        if score == ln:
            print(w)
            total_score += score
            score = 0
    print("\tTotal: ",total_score)
    print("")
    listcnt += 1

# -------------------------------------
# SAMPLE OUTPUT
# python .\GoodStrings.py

# Input: @words =  ['cat', 'bt', 'hat', 'tree']
# cat
# hat
        # Total:  6

# Input: @words =  ['hello', 'world', 'challenge']
# hello
# world
        # Total:  10
# -------------------------------------


