## Remarks
## https://www.mathblog.dk/project-euler-44-smallest-pair-pentagonal-numbers/
## https://radiusofcircle.blogspot.com/2016/06/problem-44-project-euler-solution-with-python.html
## http://radiusofcircle.blogspot.com

## Time Module for Calculating Execution Time
import time

## Time At The Start of Program Execution
dStartTime = time.time()

def is_pentagonal(nInput):
    ## Function To Check If The Number is Pentagonal Number or Not
    if (1 + (24 * nInput + 1) ** 0.5) % 6 == 0:
        return True
    return False

## Flag To Check If The Number Is Found Or Not
bFlag = True

# While Loop Iterator
nLoop = 1

# While Loop
while bFlag:
    nNum_01 = nLoop * (3 * nLoop - 1) / 2
    for nSubLoop in range(1, nLoop):
        nNum_02 = nSubLoop * (3 * nSubLoop - 1) / 2
        if is_pentagonal(nNum_01 + nNum_02) and is_pentagonal(nNum_01 - nNum_02):
            print ("nLoop = " + str(nLoop) + ", nSubLoop = " + str(nSubLoop))
            bFlag = False
            break
    nLoop = nLoop + 1

# Time At The End of Program Execution
dEndTime = time.time()

# Printing The Total Time For Execution
print ("Time Needed: " + str(dEndTime - dStartTime))


## Result
## nLoop = 2167, nSubLoop = 1020
## Time Needed: 1.1174473762512207

