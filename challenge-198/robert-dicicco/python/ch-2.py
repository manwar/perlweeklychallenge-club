#!/usr/bin/env python

'''

AUTHOR: Robert DiCicco

DATE  : 2023-01-02

Challenge 198 Prime Count ( Python )

'''

 

arr = [10,15,1,25]

 

def isprime(num):

    if num > 1: 

        for n in range(2,num): 

            if (num % n) == 0: 

                return False

        return True

    else:

        return False

 

for n in arr:

    cnt = 0

    print(f"Input: $n = {n}")

    for x in range(n):

        if isprime(x):

            #rint(x)

            cnt += 1

    print(f"Output: {cnt}\n")

   

'''

python .\PrimeCount.py

Input: $n = 10

Output: 4

 

Input: $n = 15

Output: 6

 

Input: $n = 1

Output: 0

 

Input: $n = 25

Output: 9

'''
