# Python 1.4 beta on DOSBOX

def smaller_than_current( intuple ):
 ranks=[]
 for i in range(len(intuple)):
  ranks.append((intuple[i],i))
 ranks.sort()
 ranks=map(lambda x:x[1], ranks)
 retval=[None]*len(intuple)
 retval[ranks[0]]=0
 for i in range(1,len(ranks)):
  if intuple[ranks[i]]==intuple[ranks[i-1]]:
   retval[ranks[i]]=retval[ranks[i-1]]
  else:
   retval[ranks[i]]=i
 return retval

 
print smaller_than_current( (5,2,1,6) ) # (2,1,0,3)
print smaller_than_current( (1,2,0,3) ) # (1,2,0,3)
print smaller_than_current( (0,1) )     # (0,1)
print smaller_than_current( (9,4,9,2) ) # (2,1,2,0)
