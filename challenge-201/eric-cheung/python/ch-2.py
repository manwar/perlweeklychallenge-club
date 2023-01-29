
## Remarks
## https://theweeklychallenge.org/blog/perl-weekly-challenge-201/
## https://www.geeksforgeeks.org/count-ways-reach-nth-stair/

## Python Program to Count Ways to Reach Nth stair
 
## Recursive Function to Find Nth Fibonacci Number
def GetFibNum(nInput):

    if nInput <= 1:
        return nInput

    return GetFibNum(nInput - 1) + GetFibNum(nInput - 2)

 
## Driver Program
nInputNum = 5

print ("Number of Ways: " + str(GetFibNum(nInputNum + 1)))
 
## Contributed by Harshit Agrawal
