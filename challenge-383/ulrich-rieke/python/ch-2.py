#!/usr/bin/env python3

def createConversion( ):
   conversion = {}
   for i in range( 0 , 10 ):
      conversion[str( i )] = i
   helper = "ABCDEF"
   n = 10 
   for letter in helper:
      conversion[str( letter )] = n
      n += 1
   return conversion

def roundRGB( color ):
   websafes = { "00" : 0 , "33" : 51 , "66" : 102 , "99" : 153 , "CC" : 204 ,\
      "FF" : 255}
   converted = "#" 
   colorpart = color[1:]
   conversion = createConversion( )
   hex_to_values = {}
   for k in websafes.keys( ):
      hex_to_values[websafes[k]] = k
   for n in range(0 , 3):
      currentcolor = colorpart[2 * n: 2 * n + 2]
      number = conversion[currentcolor[:1]] * 16 + conversion[currentcolor[1:2]]
      newList = sorted( websafes.values( ) , key=lambda d: abs(d - number))
      converted += hex_to_values[newList[0]]
   return converted

color = input( "Enter a RGB color!\n" )
print( roundRGB( color ))
