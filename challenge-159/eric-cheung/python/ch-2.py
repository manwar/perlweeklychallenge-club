## Remarks
## https://www.geeksforgeeks.org/program-mobius-function/

## Python program to evaluate
## Mobius def M(N) = 1 if N = 1
## M(N) = 0 if any prime factor of N is contained twice
## M(N) = (-1) ^ (no of distinct prime factors)


import math


## def to check if n is prime or not
def isPrime(n) :

    if (n < 2) :
        return False

    for i in range(2, n + 1) :
        if (n % i == 0) :
            return False
 
        i = i * i
 
    return True


def mobius(n) :

    p = 0

	## Handling 2 separately
    if (n % 2 == 0) :

        n = int(n / 2)
        p = p + 1

        ## If 2^2 also divides N
        if (n % 2 == 0) :
            return 0

    ## Check for all other prime factors
    for i in range(3, int(math.sqrt(n)) + 1) :

        ## If i divides n
        if (n % i == 0) :

            n = int(n / i)
            p = p + 1

            ## If i ^ 2 also divides N
            if (n % i == 0) :
                return 0

        i = i + 2

    if(p % 2 == 0) :
        return -1

    return 1

## Driver Code
## N = 5 ## Example: 1
## N = 10 ## Example: 2
N = 20 ## Example: 3

print ("Mobius defs M(N) at N = {} is: {}\n" . format(N, mobius(N)));

							
## This code is contributed by Manish Shaw (manishshaw1)
