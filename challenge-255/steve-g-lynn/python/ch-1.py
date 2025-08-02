
# Python 1.4 beta on DOSBOX

def odd_character( s, t ):
 in_s={}
 in_t={}
 for i in s:
  try:
   in_s[i] = in_s[i]+1
  except KeyError:
   in_s[i] = 1
 for i in t:
  try:
   in_t[i] = in_t[i]+1
  except KeyError:
   in_t[i] = 1
 for i in in_t.keys():
  if not i in in_s.keys():
   return i
  if in_t[i] > in_s[i]:
   return i
 return "ERROR"
  
print odd_character("Perl","Preel") #e
print odd_character("Weekly","Weeakly") #a
print odd_character("Box","Boxy") #y  
