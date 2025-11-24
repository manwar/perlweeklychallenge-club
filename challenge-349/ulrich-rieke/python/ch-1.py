#!/usr/bin/env python3

word = input( "Enter a word!\n" )
frequencies = {}
last_char = word[0]
count = 1
for c in word[1:]:
   if c == last_char:
      count += 1
   else:
      if c in frequencies:
         if frequencies[c] < count:
            frequencies[c] = count
      else:
         frequencies[c] = count
      count = 1
      last_char = c
if last_char in frequencies:
   if frequencies[last_char] < count:
      frequencies[last_char] = count
maxi = 1
maxchar = word[0]
for (k , v) in frequencies.items( ):
    if v > maxi:
       maxi = v
       maxchar = k
print( maxi )    
