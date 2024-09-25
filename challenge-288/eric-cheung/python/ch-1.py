
## Ref.
## https://www.geeksforgeeks.org/closest-palindrome-number-whose-absolute-difference-min/

def IsPalindrome(strInput):

    nMiddleCharPos = int((len(strInput) + (0 if len(strInput) % 2 == 0 else -1)) / 2)
    nSecondStrStart = nMiddleCharPos + (0 if len(strInput) % 2 == 0 else 1)

    ## If len(strInput) == 3 --> nMiddleCharPos = 1
    ## If len(strInput) == 4 --> nMiddleCharPos = 2

    ## print (nMiddleCharPos)
    ## print (nSecondStrStart)
    ## print (strInput[:nMiddleCharPos])
    ## print (strInput[nSecondStrStart::][::-1])

    return (strInput[:nMiddleCharPos] == strInput[nSecondStrStart::][::-1])

def GetClosestPalindrome(strInput):

    nOrigNum = int(strInput)

    ## Case 1 : Largest Palindrome Number Smaller than Given Number
    nSmallStart = nOrigNum - 1
    while not IsPalindrome(str(nSmallStart)):
        nSmallStart = nSmallStart - 1

    ## Case 2 : Smallest Palindrome Number Larger than Given Number
    nLargeStart = nOrigNum + 1
    while not IsPalindrome(str(nLargeStart)):
        nLargeStart = nLargeStart + 1

    return (nSmallStart if abs(nSmallStart - nOrigNum) <= abs(nLargeStart - nOrigNum) else nLargeStart)

## strNum = "123"  ## Example 1
## strNum = "2"  ## Example 2
## strNum = "1400"  ## Example 3
strNum = "1001"  ## Example 4

## print (IsPalindrome(strNum))
print (GetClosestPalindrome(strNum))

