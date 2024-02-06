# python 1.4 beta on DOSBOX
# (does not work on python 2 or later)

import string,regex,regsub

def most_frequent_word( p, w ):
 punct=regex.compile("[,.!?]")
 p_nopunct=regsub.gsub(punct," ",p)
 in_p={}
 p_words=string.split(p_nopunct)
 for word in p_words:
  if not word==w:
   try:
    in_p[word]=in_p[word]+1
   except KeyError:
    in_p[word]=1
 mymax=max(in_p.values())
 for word in in_p.keys():
  if (in_p[word]==mymax):
   return word
 return "ERROR!"
print most_frequent_word("Joe hit a ball, the hit ball flew far after it was hit hit", "hit") #ball  
print most_frequent_word("Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.","the") #Perl
