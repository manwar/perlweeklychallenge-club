#!/opt/local/bin/python

#
# See ../README.md
#

#
# Run as: python ch-2.py < input-file
#

def digit_sum (numbers):
    sum = 0
    for num in numbers:
        while num > 0:
            sum = sum + num % 10
            num = num // 10
    return (sum)

small_primes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31)

def factorize (num):
    out = []
    for prime in small_primes:
        while num % prime == 0:
            out . append (prime)
            num = num / prime
    if num > 1:
        out . append (num)
    return (out)


number = 1
count  = 0
  
while count < 10:
    factors = factorize (number)
    if len (factors) > 1 and digit_sum ([number]) == digit_sum (factors):
        print (number)
        count = count + 1
    number = number + 1
