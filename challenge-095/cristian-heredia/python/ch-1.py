'''

TASK #1 › Palindrome Number
Submitted by: Mohammad S Anwar
You are given a number $N.

Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.

    Example 1:
        Input: 1221
        Output: 1
    Example 2:
        Input: -101
        Output: 0, since -101 and 101- are not the same.
    Example 3:
        Input: 90
        Output: 0

'''

def palindrome(x):
    input = x
    counter = 0
    inverse = -1
    for char in input:
        if input[counter] == "-":
            print("Output: 0")
            quit()
        elif input[counter] != input[inverse]:
            print("Output: 0")
            quit()
    print("Output: 1")

palindrome("90")   


