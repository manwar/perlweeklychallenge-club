#!/usr/bin/env python3
def solution(word):
    vowels = "aAeEiIoOuU" 
    leng = len( word ) 
    firstvowels = 0
    secondvowels = 0
    for c in word[0:leng // 2 ]:
       if c in vowels:
          firstvowels += 1
    for d in word[leng // 2:]:
       if d in vowels:
          secondvowels += 1
    return firstvowels == secondvowels

print( solution("textbook"))
print( solution("book"))
print( solution("AbCdEfGh"))
print( solution("rhythmmyth"))
print( solution("UmpireeAudio"))
