'''

    TASK #1 › Maximum Gap
    Submitted by: Mohammad S Anwar
    You are given an array of integers @N.
    
    Write a script to display the maximum difference between two successive elements once the array is sorted.
    
    If the array contains only 1 element then display 0.
    
    Example
        Input: @N = (2, 9, 3, 5)
        Output: 4
    
        Input: @N = (1, 3, 8, 2, 0)
        Output: 5
        
        Input: @N = (5)
        Output: 0

'''


#Input
N = [2, 9, 3, 5]

result = 0
subs = 0
counter = 0


if (len(N) != 1):
    sortedList = sorted(N)
    while (counter < len(N)-1):
        subs = sortedList[counter+1] - sortedList[counter]
        if (subs > result):
            result = subs;
        counter += 1

print (result);








