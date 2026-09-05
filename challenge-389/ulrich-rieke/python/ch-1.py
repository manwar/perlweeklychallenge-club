#!/usr/env/python3 

composer = input( "Enter a composer name!\n" )
noteline = input( "Enter some notes separated by whitespace!\n" )
notes = [n for n in noteline.split( ' ' )]
permuline = input( "Enter a many permutations as there are notes!\n" ) ;
permutations = [int(s) for s in permuline.split( ' ' )]
output = composer.upper() 
elements = [output , "=>"]
zipped = zip( permutations , notes)
changed = sorted( zipped, key=tuple[0] )
for item in changed:
   elements.append( item[1] )
print( " ".join(elements) )    
