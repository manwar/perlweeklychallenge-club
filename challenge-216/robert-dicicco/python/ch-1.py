#!/usr/bin/env python
# ------------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-05-09
# Challenge 216 Registration Number ( Python )
# ------------------------------------------

words = [["abc", "abcd", "bcd", "AB1 2CD"], ["job", "james", "bjorg", "007 JB"], ["crack", "road", "rac", "C7 RA2"]]
out = []

def CheckWords(wd, rg):
    flag = 0
    arr = [x for x in rg]
    for lett in arr:
        if wd.count(lett) == 0:
            flag = 1
    if flag == 0:
        out.append(wd)

for wds in words:
    wds_only = wds[0:-1]
    reg = wds[-1]
    print("Input: ",wds_only,", $reg = ", reg)
    reg = reg.translate({ord(i): None for i in '1234567890 '}).lower()
    x = 0
    cnt = len(wds) - 1
    while x < cnt:
        CheckWords(wds[x],reg)
        x += 1
    print("Output: ",out,"\n")
    out = []

# ------------------------------------------
# SAMPLE OUTPUT
# python .\Registration.py
# Input:  ['abc', 'abcd', 'bcd'] , $reg =  AB1 2CD
# Output:  ['abcd']

# Input:  ['job', 'james', 'bjorg'] , $reg =  007 JB
# Output:  ['job', 'bjorg']

# Input:  ['crack', 'road', 'rac'] , $reg =  C7 RA2
# Output:  ['crack', 'rac']
# ------------------------------------------




