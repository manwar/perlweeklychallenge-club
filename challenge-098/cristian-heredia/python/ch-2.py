'''

TASK #2 › Search Insert Position
Submitted by: Mohammad S Anwar
You are given a sorted array of distinct integers @N and a target $N.

Write a script to return the index of the given target if found otherwise place the target in the sorted array and return the index.

    Example 1:
        Input: @N = (1, 2, 3, 4) and $N = 3
        Output: 2 since the target 3 is in the array at the index 2.
    Example 2:
        Input: @N = (1, 3, 5, 7) and $N = 6
        Output: 3 since the target 6 is missing and should be placed at the index 3.
    Example 3:
        Input: @N = (12, 14, 16, 18) and $N = 10
        Output: 0 since the target 10 is missing and should be placed at the index 0.
    Example 4:
        Input: @N = (11, 13, 15, 17) and $N = 19
        Output: 4 since the target 19 is missing and should be placed at the index 4.

'''

#Input
NList = (1, 2, 3, 4)
N = 3

#Function to check if the target is in the list
def findNumber():
    #walk through the list
    for num in range(len(NList)):
        #If the target is in the list, it will return its position
        if NList[num] == N:
            return num
    return -1

#Call the function to search in the list
findNumber()

#If the target isn't in the list, the target will be added into the list and the "new list" will be sorted. Then, call the search function (with the new list)
if (findNumber() == -1 ):
    numbers = list(NList)
    numbers.append(N)
    NList = sorted(numbers)
    findNumber()
    
#Print the position of target inside the list
print (findNumber())

