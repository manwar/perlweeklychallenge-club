' Challenge 089
'
' TASK #1 › GCD Sum
' Submitted by: Mohammad S Anwar
' You are given a positive integer $N.
'
' Write a script to sum GCD of all possible unique pairs between 1 and $N.

Function gcd(a as Long, b as Long) as Long
    If a=0 Then
        gcd = b
    Else
        gcd = gcd(b Mod a, a)
    EndIf
End Function

Function sum_gcd(n as Long) as Long
    Dim sum as Long, a as Long, b as Long
    For a=1 to n-1
        For b=a+1 to n
            sum = sum + gcd(a,b)
        Next b
    Next a
    sum_gcd = sum
End Function

dim n as Long
n = Val(Command(1))
Print sum_gcd(n)
