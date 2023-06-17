
## Remarks
## https://www.geeksforgeeks.org/generating-all-possible-subsequences-using-recursion/

## Python3 code to print all possible subsequences for given array using recursion
## Recursive function to print all possible subsequences for given array

nMaxArrLen = 0

def IsArithmetic (arrListCheck):

    nDiff = arrListCheck[1] - arrListCheck[0]
    for nIndxLoop in range(2, len(arrListCheck)):
        if arrListCheck[nIndxLoop] - arrListCheck[nIndxLoop - 1] != nDiff:
            return False

    return True

def GenSubseqArr (arrFunc, nIndx, subArrFunc):

    global nMaxArrLen

    ## Print the subsequence when reach the leaf of recursion tree
    if nIndx == len(arrFunc):
        ## Condition to avoid printing empty subsequence
        ## if len(subArrFunc) > 0:
        if len(subArrFunc) > 2 and IsArithmetic(subArrFunc):
            ## print (subArrFunc)
            if len(subArrFunc) > nMaxArrLen:
                nMaxArrLen = len(subArrFunc)

    else:
        ## Subsequence without including the element at current nIndx
        GenSubseqArr(arrFunc, nIndx + 1, subArrFunc)

        ## Subsequence including the element at current nIndx
        GenSubseqArr(arrFunc, nIndx + 1, subArrFunc + [arrFunc[nIndx]])

    return

arrGivenMain = [9, 4, 7, 2, 10]  ## Example 1
## arrGivenMain = [3, 6, 9, 12]  ## Example 2
## arrGivenMain = [20, 1, 15, 3, 10, 5, 8]  ## Example 3

GenSubseqArr(arrGivenMain, 0, [])

print (nMaxArrLen)
