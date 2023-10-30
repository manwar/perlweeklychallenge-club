#!/usr/bin/env python
# ------------------------------------
# AUTHOR: Robert DiCicco
# DATE  : 2023-10-21
# Challenge 240 Task 01 Acronym ( Python )
# ------------------------------------

mystr = [["Perl", "Python", "Pascal"],["Perl", "Raku"],["Oracle", "Awk", "C"]]
mychk = ["ppp","rp","oac"]

cnt = 0

def GetFirstLetters(wds):
    acronym = ""
    for w in wds:
        acronym += w[0].lower()
    return acronym

for str in mystr:
    print(f"Input: @str = {str}")
    print(f"check = \"{mychk[cnt]}\"")
    retval = GetFirstLetters(str)
    if retval == mychk[cnt] :
        print("Output: true\n")
    else :
        print("Output: false\n")
    cnt += 1

# ------------------------------------
# SAMPLE OUTPUT

# python .\Acronym.py

# Input: @str = ['Perl', 'Python', 'Pascal']
# check = "ppp"
# Output: true

# Input: @str = ['Perl', 'Raku']
# check = "rp"
# Output: false

# Input: @str = ['Oracle', 'Awk', 'C']
# check = "oac"
# Output: true
# ------------------------------------
