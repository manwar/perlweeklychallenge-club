"""

    TASK #1 › JortSort
    Submitted by: Mohammad S Anwar
    You are given a list of numbers.

    Write a script to implement JortSort. It should return true/false depending if the given list of numbers are already sorted.

        Example 1:
            Input: @n = (1,2,3,4,5)
            Output: 1

            Since the array is sorted, it prints 1.
        Example 2:
            Input: @n = (1,3,2,4,5)
            Output: 0

            Since the array is NOT sorted, it prints 0.

"""

# Input
n = (1, 2, 3, 4, 5)

sortN = sorted(n)
for i in range(len(n)):
    if n[i] != sortN[i]:
        print("0")
        exit()
print("1")
