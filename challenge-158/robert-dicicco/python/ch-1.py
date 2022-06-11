#!python.exe

# AUTHOR: Robert DiCicco
# DATE: 29-MAR-2022
# Challenge 158 Additive Primes ( Python )

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
    return -1
  else:
    return 1

def sumOfDigits(n):
  sum = 0
  for digit in str(n):
    sum += int(digit)

  x = checkPrime(sum)

  if x > 0 :
    return n

  return -1

TARGET=100

i=2

while i < TARGET :
  retval = sumOfDigits(i)

  if retval > 0 :
    nuval = checkPrime(retval)
    if nuval > 0:
      print("%d " % retval, end='')

  i += 1

print("\n")
