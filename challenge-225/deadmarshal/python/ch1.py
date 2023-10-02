#!/usr/bin/env python3

def max_words(arr):
  return max(map(lambda s: len(s.split(sep=' ')),arr))
  
print(max_words(["Perl and Raku belong to the same family.",
		 "I love Perl.",
		 "The Perl and Raku Conference."]))
print(max_words(["The Weekly Challenge.",
		 "Python is the most popular guest language.",
		 "Team PWC has over 300 members."]))

