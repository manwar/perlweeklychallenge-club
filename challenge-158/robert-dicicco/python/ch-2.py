#!python.exe

# AUTHOR: Robert DiCicco
# DATE: 29-MAR-2022
# Challenge 158 Cuban Primes ( Python )

def checkPrime( num ):
  # prime numbers are greater than 1
  flag = False

  if num > 1:
    # check for factors
    for i in range(2, num):
        if (num % i) == 0:
            # if factor is found, set flag to True
            flag = True
            # break out of loop
            break

  if flag:
    return -1 # NOT a prime
  else:
    return(1) # Is a prime

def makeCuban( num ):
  cuban = ((3 * (num**2)) + (3 * num) + 1) # formula for a cuban numbe
  x = checkPrime(cuban)   # return the cuban if it is prime

  if (x > 0) :
    return(cuban)
  else:
    return(-1)            # otherwise return -1

TARGET = 1000
i = 1

while True :                      # loop until the cuban is greater than 1000
 retval = makeCuban(i)
 if retval > TARGET :
   break

 if retval > 0 :                  # We have a cuban
   print("%d " % retval, end='')  # and print it

 i += 1

print("\n")
