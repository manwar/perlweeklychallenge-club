import re

def findParts( word , partnum):
    parts = []
    i = 0
    pos = 0
    while i < partnum:
        parts.append( word[pos:pos + 3] )
        pos += 3
        i += 1
    return parts
      
phonenumber = input( "Enter a string consisting of digits, dashes and spaces only!\n")
reduced = re.sub(r"\s|\-" , "" , phonenumber) 
l = len( reduced ) 
if l <= 4:
   if l == 4:
      print( reduced[0:2] + '-' + reduced[2:] ) 
   else:
      print( reduced )
else:
   restlen = l % 3
   partnumber = l // 3 
   if restlen == 1:
      partnumber -= 1
   parts = findParts( reduced , partnumber )
   restterm = reduced[partnumber * 3:]
   if len(restterm) == 0:
      print('-'.join( parts ))
   else:
      solution = '-'.join( parts ) 
      if len( restterm ) == 4:
         print( solution + '-' + restterm[0:2] + '-' + restterm[2:] ) 
      else:
         print( solution + '-' + restterm )
