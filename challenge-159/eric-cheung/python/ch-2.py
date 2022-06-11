## Remarks
## https://www.geeksforgeeks.org/equilibrium-index-of-an-array/

## Python Program to Find Equilibrium Index of an Array

## Function to Find the Equilibrium Index
def equilibrium(arr):
    leftsum = 0
    rightsum = 0

    n = len(arr)

	## Check for Indexes one by one until an equilibrium index is found
    for i in range(n):
        leftsum = 0
        rightsum = 0

		## Get Left Sum
        for j in range(i):
            leftsum = leftsum + arr[j]

		## Get Right Sum
        for j in range(i + 1, n):
            rightsum = rightsum + arr[j]

		## If Left Sum and Right Sum are same, then we are done
        if leftsum == rightsum:
            return i
	
	## return -1 if no equilibrium index is found
    return -1
			

## Driver Code
arr = [1, 3, 5, 7, 9] ## Example 1:
## arr = [1, 2, 3, 4, 5] ## Example 2:
## arr = [2, 4, 2] ## Example 3:

print (equilibrium(arr))

## This code is contributed by Abhishek Sharama
