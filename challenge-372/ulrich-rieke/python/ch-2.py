#!/usr/bin/env python3

word = input( "Enter a string!\n" )
frequencies = {}
for letter in word:
   if letter in frequencies:
      frequencies[letter] += 1
   else:
      frequencies[letter] = 1
truths = [val == 1 for val in frequencies.values()]
if all( truths ):
   print(-1)
else:
   most_frequent = []
   for letter in word:
      if frequencies[letter] > 1:
         most_frequent.append( letter )
   max_distance = 0 
   for letter in most_frequent:
      distance = word.rindex( letter ) - word.index( letter ) - 1 
      if distance > max_distance:
         max_distance = distance
   print( max_distance )
