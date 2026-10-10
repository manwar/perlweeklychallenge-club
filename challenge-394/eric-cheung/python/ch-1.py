
## strInput = "aAbB"  ## Example 1
## strInput = "AAbb"  ## Example 2
## strInput = "AAAbbb"  ## Example 3
## strInput = "aABb"  ## Example 4

strInput = "bBBAaa"  ## Example 5

GetCalcSwap = (lambda arrUpIndx, arrIndxPos : sum([abs(nCurIndx - nTargetIndx) for nCurIndx, nTargetIndx in zip(arrUpIndx, arrIndxPos)]))

def GetMinSwapsToAlter(strGiven):

    nLen = len(strGiven)

    arrUpperIndx = [nIndx for nIndx, charLoop in enumerate(strGiven) if charLoop.isupper()]
    arrLowerIndx = [nIndx for nIndx, charLoop in enumerate(strGiven) if charLoop.islower()]

    if len(arrUpperIndx) != len(arrLowerIndx):
        raise ValueError("The string must contain an equal number of uppercase and lowercase letters.")

    ## Case 1: Pattern Starts With Uppercase (Indices: 0, 2, 4, ...)
    arrTargetUpCase_01 = list(range(0, nLen, 2))
    nSwapCase_01 = GetCalcSwap(arrUpperIndx, arrTargetUpCase_01)

    ## Case 2: Pattern Starts With Lowercase (Indices: 1, 3, 5, ...)
    arrTargetUpCase_02 = list(range(1, nLen, 2))
    nSwapCase_02 = GetCalcSwap(arrUpperIndx, arrTargetUpCase_02)

    ## Return the Minimum Swaps Needed Between Both Valid Target Patterns
    return min(nSwapCase_01, nSwapCase_02)


print (GetMinSwapsToAlter(strInput))
