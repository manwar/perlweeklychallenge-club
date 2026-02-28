#!/usr/bin/env python3

def findNumberString( number , conversions):
   numberstring = str( number )
   l = len( numberstring)
   result = ""
   if l == 1:
      result += conversions[number]
   if l == 2:
      if number % 10 == 0:
         result += conversions[number]
      else:
         result += conversions[(number // 10) * 10] + "-" + conversions[number % 10]
   if l == 3:
      if number % 100 == 0:
         result += conversions[number / 100] + " hundred"
      else:
         result += findNumberString(((number // 100) * 100) , conversions) \
                   + " hundred and" \
                   + findNumberString( number % 100 , conversions)
   if l > 3 and l < 7:
      if number % 1000 == 0:
         result += conversions[ number / 1000] + " thousand" 
      else:
         result += findNumberString(((number // 1000) * 1000), conversions)\
                   + " thousand " \
                   + findNumberString( number % 1000 , conversions )
   if l > 6 and l < 10:
      if number % 1000000 == 0:
         result += conversions[number / 1000000] + " million"
      else:
         result += findNumberString(((number // 1000000) * 1000000) , conversions) \
                   + " million " \
                   + findNumberString( number % 1000000 , conversions)
   return result 
            
def compose( number , conversions):
   string = ""
   if number < 0:
      string += "minus "
   number = abs( number )
   string += findNumberString( number , conversions)
   return string

mappings = { 0 : "zero" , 1 : "one" , 2: "two" , 2: "two" , 3 : "three" ,
             4 : "four" , 5 : "five" , 
             6: "six" , 7 : "seven" , 8 : "eight" , 9 : "nine" , 10 : "ten" , 
             11 : "eleven" , 12 : "twelve" , 13 : "thirteen" , 14 : "fourteen" , 
             15 : "fifteen" , 16 : "sixteen" , 17 : "seventeen" , 18 : "eighteen" , 
             19 : "nineteen" , 20 : "twenty" , 30 : "thirty" , 40 : "forty" , 
             50 : "fifty" , 60: "sixty" , 70 : "seventy" , 80 : "eighty" , 
             90 : "ninety" }
line = input( "Enter some integers separated by whitespace!\n" )
numbers = []
for w in line.split( ' ' ):
   numbers.append( int( w ) )
pairs = map( lambda n : ( n , compose( n, mappings )) , numbers )
pairlist = list( pairs )
mySorted = sorted( pairlist , key=lambda p: p[1])
result = [p[0] for p in mySorted]
print( result )   
