## Remarks
from math import sqrt

## Code to Find all the Factors of the Number Excluding the Number itself
def getFactors(nInput):

    ## Vector to Store the Factors
    vectArr = []
    vectArr.append(1)

    ## Note that this Loop runs till sqrt(nInput)
    for nSubLoop in range(2, int(sqrt(nInput)) + 1, 1):
        ## if the value of nSubLoop is a factor
        if (nInput % nSubLoop == 0):
            vectArr.append(nSubLoop);

            ## Condition to Check the Divisor is not the Number itself
            if (int(nInput / nSubLoop) != nSubLoop):
                vectArr.append(int(nInput / nSubLoop))

	## Return the Vector
    return vectArr

## Function to check if the number is Abundant or not
def checkAbundant(nInput):
    nSum = 0

	## Find the Divisors Using Function
    vec = getFactors(nInput)

    ## nSum All the Factors
    for nSubLoop in range(len(vec)):
        nSum = nSum + vec[nSubLoop]

    ## Check for Abundant or Not
    if (nSum > nInput):
        return True

    return False


## Driver Code
if __name__ == '__main__':

    nLoop = 11
    nCount = 0
    arrAbundantNum = []

    while nCount < 20:

        if checkAbundant(nLoop):
            arrAbundantNum.append(nLoop)
            nCount = nCount + 1

        nLoop = nLoop + 2

    print (arrAbundantNum)

## [945, 1575, 2205, 2835, 3465, 4095, 4725, 5355, 5775, 5985, 6435, 6615, 6825, 7245, 7425, 7875, 8085, 8415, 8505, 8925]
