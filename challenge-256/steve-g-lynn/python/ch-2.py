# python 1.4 beta on DOSBOX

import string

def merge_strings( str1, str2 ):
 max_len=max( len(str1), len(str2) )
 retval=[]
 for i in range(max_len):
  if (len(str1) > i):
   retval.append( str1[i] )
  if (len(str2) > i):
   retval.append( str2[i] )
 return string.joinfields(retval,"")
 
print merge_strings("abcd","1234") # a1b2c3d4
print merge_strings("abc","12345") # a1b2c345
print merge_strings("abcde","123") # a1b2c3de    
