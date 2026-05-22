#!/use/bin/env python3

numberstring = input( "Enter a string consisting of grouped digits only!\n")
frequencies = {}
uniques = set( numberstring )
frequencies = {letter: numberstring.count( letter ) for letter in uniques}   
maxi = 0
for k in frequencies.keys( ):
   if k != '0':
      current = int(k * frequencies[k])
      if current > maxi:
         maxi = current
print( maxi )   
