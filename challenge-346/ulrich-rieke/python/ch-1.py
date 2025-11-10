#!/usr/bin/env python3

def findLength( word , start):
   balances = []
   balance = 1 
   length = len( word )
   balances.append( balance )
   start += 1
   while start < length:
      letter = word[start] 
      if letter == '(':
         balance += 1
      else:
         balance -= 1
      if balance < 0:
         break	 
      balances.append( balance )
      start += 1
   howmany = balances.count( 0 )
   result = 0
   if howmany == 0:
      result = 0
   elif howmany == 1:
      result = balances.index( 0 ) + 1
   else:
      cur = len(balances) - 1
      while balances[cur] != 0:
          cur -= 1
      result = cur + 1
   return result
   
string = input( "Enter a string consisting of parentheses only!\n" ) 
length = len( string )
lengths = []   
for pos in range(0 , length - 1):
   if string[pos] == '(':
      lengths.append( findLength( string , pos ))
print( max( lengths ) )   
