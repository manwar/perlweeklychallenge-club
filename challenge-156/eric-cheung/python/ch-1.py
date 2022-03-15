## Remarks
## https://www.geeksforgeeks.org/pernicious-number/
## Python program to print first nNum Pernicious Numbers

## Function to Check Prime Number
def isPrime(nInput):
    if nInput < 2:
        return False

    for nSubLoop in range(2, nInput):
        if not nInput % nSubLoop:
            return False

    return True


# Prints First nNum Pernicious Numbers
def printPernicious(nNum):

    nLoop, nCount = 1, 0

    while nCount < nNum:
        # "bin(nLoop).count('1')" Count No. of ones in Binary Representation
        if (isPrime(bin(nLoop).count('1'))):
            print(nLoop, end = ' ')
            nCount = nCount + 1

        nLoop = nLoop + 1

## Driver Code
nNum = 10
printPernicious(nNum)

## This Code is Contributed by Ansu Kumari
