#/usr/bin/env python
'''
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-06
Challenge 207 Keyboard Word ( Python )
--------------------------------------
'''

rows = ["qwertyuiop", "asdfghjkl", "zxcvbnm"]
words = ["Hello", "Alaska", "Dad", "Peace"], ["OMG", "Bye"]
flag = 0

def CheckLetters(w):
    ln = len(w)
    for j in range(3):
        flag = 0
        for x in range(ln):
            if (w[x] in rows[j]):
                pass
            else:
                flag = 1
        if flag == 0 :
            print("\t",w)
        flag = 0

for wds in words:
    print("Input: @words = ",wds)
    print("Output: ")
    ln = len(wds)
    for j in range(0,ln):
        CheckLetters(wds[j].lower())
    print(" ")

'''
--------------------------------------
SAMPLE OUTPUT
python .\KeyboardWord.py
Input: @words =  ['Hello', 'Alaska', 'Dad', 'Peace']
Output:
         alaska
         dad

Input: @words =  ['OMG', 'Bye']
Output:

'''
