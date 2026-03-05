#!/usr/bin/env python3

def solution( sentence ):
  mappings = { 0 : "zero" , 1 : "one" , 2: "two" , 2: "two" , 3 : "three" ,
             4 : "four" , 5 : "five" ,
             6: "six" , 7 : "seven" , 8 : "eight" , 9 : "nine" , 10 : "ten" ,
             11 : "eleven" , 12 : "twelve" , 13 : "thirteen" , 14 : "fourteen" ,
             15 : "fifteen" , 16 : "sixteen" , 17 : "seventeen" , 18 : "eighteen" ,
             19 : "nineteen" , 20 : "twenty" }
  allWords = sentence.split( " " )
  vowelcount = 0
  consocount = 0
  vowels = "AEIOUaeiou"
  for c in allWords[0]:
     if c in vowels:
        vowelcount += 1
     else:
        consocount += 1
  return mappings[vowelcount] == allWords[2] and mappings[consocount] == allWords[5]

print( solution( "aa - two vowels and zero consonants"))
print( solution( "iv - one vowel and one consonant"))
print( solution( "hello - three vowels and two consonants"))
print( solution( "aeiou - five vowels and zero consonants"))
print( solution( "aei - three vowels and zero consonants"))

