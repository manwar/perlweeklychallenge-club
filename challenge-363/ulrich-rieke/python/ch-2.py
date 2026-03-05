#!/usr/bin/env python3

def isValidAddress( ipv4 ):
   truthvalues = []
   parts = []
   for p in ipv4.split( "." ):
      parts.append( p )
   truthvalues.append( len( parts ) == 4 )   
   allDigits = [word.isnumeric() for word in parts]   
   truthvalues.append( all(allDigits) )
   numbers = [int( w ) for w in parts]
   allInRange = [(n >= 0 and n <= 255) for n in numbers]
   truthvalues.append( all( allInRange ) )
   truthvalues.append( all( allDigits ))
   return all( truthvalues )

def toPaddedBinary( number ):
   binary = ""
   while number != 0:
      if number % 2 == 1:
         binary += '1'
      else:
         binary += '0'
      number //= 2
   binary = binary[::-1]
   paddedString = ""
   for i in range( 0 , 8 - len( binary)):
      paddedString += '0'
   paddedString += binary
   return paddedString

ipv4 = input( "Enter an IPv4 address!\n" ) 
cidr = input( "Enter a network address in CIDR format!\n")
networkparts = cidr.split( "/" ) 
result = False 
if isValidAddress( ipv4 ) and isValidAddress( networkparts[0] ):
   if networkparts[1].isnumeric( ):
      number = int( networkparts[1] )
      if number >= 0 and number <= 32:
         total_ipv4Octets = ""
         total_networkOctets = ""
         for p in ipv4.split( "." ):
            numberpart = int( p )
            total_ipv4Octets += toPaddedBinary( numberpart )
         for p in networkparts[0].split( "." ):
            numberpart = int( p )
            total_networkOctets += toPaddedBinary( numberpart )
         result = total_ipv4Octets[0:number] == total_networkOctets[0:number]
print( result )            
