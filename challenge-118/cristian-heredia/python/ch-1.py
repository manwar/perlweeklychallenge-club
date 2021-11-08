'''  
    TASK #1 › Binary Palindrome
    Submitted by: Mohammad S Anwar
    You are given a positive integer $N.

    Write a script to find out if the binary representation of the given integer is Palindrome. Print 1 if it is otherwise 0.

        Example
            Input: $N = 5
            Output: 1 as binary representation of 5 is 101 which is Palindrome.

            Input: $N = 4
            Output: 0 as binary representation of 4 is 100 which is NOT Palindrome.
    

'''   

N = 5

bits = f'{N:b}'
j = -1

for num in bits:
    if num != bits[j]:
        print("Output: 0")
        exit()
    j -= 1
print("Output: 1")
