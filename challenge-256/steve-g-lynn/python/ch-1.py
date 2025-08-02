# Python 1.4 beta on DOSBOX

import string

def maximum_pairs( words ):
 seen={}
 count=0
 for i in words:
  rev_i=list(str(i))
  rev_i.reverse()
  rev_i=string.joinfields( rev_i, "" )
  if seen.has_key(rev_i) and seen[rev_i]==1:
   count=count+1
   seen[rev_i]=0
  else:
   seen[i]=1
 return count
 
print maximum_pairs( ["ab", "de", "ed", "bc" ] ) #1
print maximum_pairs( ["aa", "ba", "cd", "ed" ] ) #0
print maximum_pairs( ["uv", "qp", "st", "vu", "mn", "pq"] ) #2
