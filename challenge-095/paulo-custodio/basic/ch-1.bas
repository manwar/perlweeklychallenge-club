' Challenge 095
'
' TASK #1 › Palindrome Number
' Submitted by: Mohammad S Anwar
' You are given a number $N.
'
' Write a script to figure out if the given number is Palindrome. Print 1 if true otherwise 0.
'
' Example 1:
' Input: 1221
' Output: 1
' Example 2:
' Input: -101
' Output: 0, since -101 and 101- are not the same.
' Example 3:
' Input: 90
' Output: 0

Function is_palindrome(n as long) as integer
    dim p10 as long

    ' negative numbers are not palindromes
    if n < 0 then
        is_palindrome = 0
        exit function
    end if

    ' find highest power of 10 < n
    p10 = 1
    do while n > p10*10
        p10 = p10*10
    loop

    ' remove highest and lowest digits until number is <10
    do while n >= 10
        if (n mod 10) <> int(n/p10) then
            is_palindrome = 0
            exit function
        end if
        n = int((n mod p10) / 10)       ' remove high and low digits
        p10 = int(p10 / 100)
    loop

    'if number is less than 10, it is a palindrome
    is_palindrome = 1
End Function

print trim(str(is_palindrome(val(command(1)))))
