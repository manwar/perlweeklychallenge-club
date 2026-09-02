#!/usr/bin/python3

def isUndulating( numbers ):
   num = numbers[0]
   l = len( numbers )
   vals = [n == num for n in numbers]
   if all(vals):
      return True
   elif l == 2:
      return (numbers[0] != numbers[1])
   else:
      differences = []
      for i in range( 1 , l ):
         differences.append( numbers[i] - numbers[i - 1] )
      valus = [((differences[n] < 0 and differences[n + 1] > 0) or \
            (differences[n] > 0 and differences[n + 1] < 0)) for n in \
             range( 0 , len( differences ) - 1)]
      return all(valus)

def createSubarrays( numbers ):
   allSubarrays = [numbers[start:end] for start in range( 0 ,  \
         len( numbers ) - 1 ) for end in range( start + 1 ,  \
         len( numbers) + 1)]
   return allSubarrays

def myLength( array ):
   number = array[0]
   vals = [n == number for n in array]
   if all( vals ):
      return 1
   else:
      return len( array )

numberline = input( "Enter some integers separated by whitespace!\n")
numbers = [int(n) for n in numberline.split( ' ' )]
subarrays = createSubarrays( numbers )
sizes = [myLength( vec ) for vec in subarrays if isUndulating( vec )]
sizes.sort()
print( sizes[-1] )   
