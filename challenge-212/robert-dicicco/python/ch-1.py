#!/usr/bin/env python
'''
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-10
Challenge 212 Jumping Letters ( Python )
---------------------------------------
'''

word = 'Perl'
jump = [2,22,19,9]

#word = 'Raku'
#jump = [24,4,7,17]

alphabet = ["a","b","c","d","e","f","g","h","i","j",
            "k","l","m","n","o","p","q","r","s","t",
            "u","v","w","x","y","z"]

print(f"Input: $word = '{word}' and @jump = {jump}")

print("Output: ",end="")

for n in range(len(word)):
    ndx = alphabet.index(word[n].lower())
    print(alphabet[ndx % 26].upper(),end="") if n==0 else  print(alphabet[ndx % 26],end="")

'''
---------------------------------------
SAMPLE OUTPUT
python .\Jumping.py
Input: $word = 'Perl' and @jump = [2, 22, 19, 9]
Output: Perl

PS G:\Projects\Perl\Challenges> python .\Jumping.py
Input: $word = 'Raku' and @jump = [24, 4, 7, 17]
Output: Raku
---------------------------------------
'''
