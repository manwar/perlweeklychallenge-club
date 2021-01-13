#!/usr/bin/env python3

# Perl Week Challenge 064 - Task #2
# You are given a string $S and an array of words @W.
# Write a script to find out if $S can be split into
# sequence of one or more words as in the given @W.
# Print the all the words if found otherwise print 0.

string = 'perlweeklychallenge'
words = ["weekly", "challenge", "perl"]

# string = 'perlandraku'
# words = ["python", "ruby", "haskell"]

slurp = ''.join(words)

if len(string) != len(slurp):
   print(0)
   exit() 

pos = {}

for word in words:
   i = string.find(word)
   if i == -1:
      print(0)
      exit()
   pos[i] = word

result = [ pos[x] for x in sorted(pos) ]
print(result)

