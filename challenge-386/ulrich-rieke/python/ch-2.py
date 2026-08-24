#!/user/bin/env python3

def parse( numberstring ):
   parts = []
   pointpos = numberstring.find( '.' )
   parts.append( numberstring[0:pointpos] )
   bracketpos = numberstring.find( '(' ) 
   if bracketpos == -1:
      parts.append( "" )
      parts.append( "" )
   else :
      parts.append( numberstring[pointpos + 1 : bracketpos] )
      parts.append( numberstring[bracketpos + 1 : -1] )
   return parts

def expand( array ):
   expanded = ""
   expanded += array[0]
   expanded += "."
   if len( array[2]) > 0:
      expanded += array[1]
      for i in range(0 , 4):
         expanded += array[2]
   return expanded

def isSame( firstnumber , secondnumber ):
   firstparts = parse( firstnumber )
   secondparts = parse( secondnumber )
   if (all([c == '9' for c in firstparts[1]]) or len( firstparts[1] ) == 0) \
   and all ([c == '9' for c in firstparts[2]]) and len(secondparts[1]) == 0 \
   and len( secondparts[2] ) == 0:
      return int( secondparts[0] ) == int( firstparts[0] ) + 1 
   else:
      firstexpanded = expand( firstparts )
      secondexpanded = expand( secondparts )
      return firstexpanded[0:len( secondexpanded)] == secondexpanded or \
        secondexpanded[0:len( firstexpanded )] == firstexpanded
  
rat1 = input( "Enter a rational number!\n" )
rat2 = input( "Enter another rational number!\n")
print( isSame( rat1 , rat2 ))
