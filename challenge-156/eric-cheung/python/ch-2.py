## Remarks
## https://www.geeksforgeeks.org/weird-number/

## Python 3 Program to Check if the Number is Weird or not
from math import sqrt

## Code to Find all the Factors of the Number Excluding the Number itself
def factors(n):

    ## Vector to Store the Factors
    v = []
    v.append(1)

    ## Note that this Loop runs till sqrt(n)
    for i in range(2, int(sqrt(n)) + 1, 1):
        ## if the value of i is a factor
        if (n % i == 0):
            v.append(i);

            ## Condition to Check the Divisor is not the Number itself
            if (int(n / i) != i):
                v.append(int(n / i))

	# return the vector
    return v

## Function to check if the number is Abundant or not
def checkAbundant(n):
    sum = 0

	## Find the Divisors Using Function
    v = factors(n)

    ## Sum All the Factors
    for i in range(len(v)):
        sum = sum + v[i]

    ## Check for Abundant or Not
    if (sum > n):
        return True

    return False

## Function to Check if the Number is Semi-Perfect or not
def checkSemiPerfect(n):
    ## find the divisors
    v = factors(n)

    ## sorting the vector
    v.sort(reverse = False)
    r = len(v)

    ## subset to check if no is semiperfect
    subset = [[0 for i in range(n + 1)] for j in range(r + 1)]

    ## initialising 1st column to true
    for i in range(r + 1):
        subset[i][0] = True

    ## Initialing 1st Row Except Zero Position to 0
    for i in range(1, n + 1):
        subset[0][i] = False

    ## Loop to Find Whether the Number is Semiperfect
    for i in range(1, r + 1):
        for j in range(1, n + 1):

            ## Calculation to check if the Number can be made by Summation of Divisors
            if (j < v[i - 1]):
                subset[i][j] = subset[i - 1][j]
            else:
                subset[i][j] = (subset[i - 1][j] or subset[i - 1][j - v[i - 1]])

    ## If not possible to make the Number by any combination of Divisors
    if ((subset[r][n]) == 0):
        return False

    return True

## Function to check for Weird or Not
def checkweird(n):
    if (checkAbundant(n) and not checkSemiPerfect(n)):
        return True

    return False

# Driver Code
if __name__ == '__main__':
    ## n = 12 ## Example 1:
    n = 70 ## Example 2:

    if (checkweird(n)):
        print("Weird Number")
    else:
        print("Not Weird Number")

## This code is contributed by Surendra_Gangwar
