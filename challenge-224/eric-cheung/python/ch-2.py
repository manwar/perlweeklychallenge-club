
## Remarks
## https://www.geeksforgeeks.org/string-with-additive-sequence-set-2/

## python3 code to implement the approach
 
## Variable to store the result
bResult = False
arrStr = []
 
## Function to check the additive sequence
def check_additive(strIn, subStrIn):
    global bResult
    global arrStr
     
    ## If the end is reached and vector consists of more than 2 numbers, then one of the possible solution is found
    if (subStrIn == len(strIn) and len(arrStr) > 2):

        ## Mark the bResult as true to indicate the solution is found and to avoid for trying the rest of the combinations
        bResult = True
        return

    nInt_01, nInt_02, nInt_03 = 0, 0, 0

    if (len(arrStr) >= 2):
        ## Store the previous two numbers of the sequence to check the additive sequence property for the next number
        nInt_02 = arrStr[len(arrStr) - 1]
        nInt_01 = arrStr[len(arrStr) - 2]

    for nIndxLoop in range(subStrIn, len(strIn)):
 
        ## Generate the number
        nInt_03 = nInt_03 * 10 + ord(strIn[nIndxLoop]) - ord("0")
 
        ## Try all the possible ways to generate the first two numbers
        ## i.e. if vector consists of less than two numbers and no solution is found yet
        if (len(arrStr) < 2):
            arrStr.append(nInt_03)
            check_additive(strIn, nIndxLoop + 1)
 
            ## Pop the value to try for the other combination
            arrStr.pop()

            ## If the number generated so far is not equal the sum of previous two numbers in the sequence
            ## then it cannot be a part of additive sequence hence no need to proceed further

            return

        if (nInt_03 != nInt_01 + nInt_02):
            return

        ## If the number generated so far is equal to the sum of previous two numbers
        ## then it can be a part of additive sequence
        ## push it into vector and check for remaining string

        ## Store it in the vector 
        arrStr.append(nInt_03)

        ## Recur for remaining string
        check_additive(strIn, nIndxLoop + 1)
 
        ## If unable to find solution
        ## pop it and try for other combination
        arrStr.pop()

    return

## Function to check if additive sequence
def IsAdditiveSeq(strInputFunc):
    global bResult
     
    ## In order to form additive sequence, the length of the string must be at least three
    if (len(strInputFunc) <= 2):
        return False
 
    bResult = False
    check_additive(strInputFunc, 0)
    return bResult
 
## Driver Code
if __name__ == "__main__":

    ## strInput = "112358"  ## Example 1
    ## strInput = "12345"  ## Example 2
    strInput = "199100199"  ## Example 3

    print (IsAdditiveSeq(strInput))
