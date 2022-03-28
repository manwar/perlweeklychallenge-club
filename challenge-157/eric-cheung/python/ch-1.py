## Remarks
## https://www.geeksforgeeks.org/additive-prime-number/

## Python3 Program For the Above Approach

## Check if nNum_01 is Prime or Not
def isPrime(nNum_01):
    if (nNum_01 <= 1):
        return False

    if (nNum_01 <= 3):
        return True

	## This is Checked to Skip Middle Five Numbers
    if (nNum_01 % 2 == 0 or nNum_01 % 3 == 0):
        return False

    nLoop = 5
    while (nLoop * nLoop <= nNum_01):
        if (nNum_01 % nLoop == 0 or nNum_01 % (nLoop + 2) == 0):
            return False

        nLoop = nLoop + 6

    return True

## Function to Get Sum of Gigits
def getSum(nNum_02):
    nSum = 0
    while (nNum_02 != 0):
        nSum = nSum + nNum_02 % 10
        nNum_02 = int(nNum_02 / 10)

    ## Return the nSum of digits
    return nSum

## Function to Check Whether the Given number is Additive Prime number or Not
def isAdditivePrime(nNum_03):

    ## If Number is not prime
    if not isPrime(nNum_03):
        return False

    ## print ("getSum(" + str(nNum_03) + "): " + str(getSum(nNum_03)))

    ## Check if Sum of Digits Is Prime or Not
    return isPrime(getSum(nNum_03))


## Driver Code

## Given Number nInput
nInputLoop = 2
while (nInputLoop <= 100):

    ## Function Call
    if (isAdditivePrime(nInputLoop)):
        print (str(nInputLoop))

    nInputLoop = nInputLoop + 1

## This code is contributed by Pratik Basu
