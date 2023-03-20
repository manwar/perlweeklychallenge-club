' Challenge 198
'
' Challenge 198
'
' Task 2: Prime Count
' Submitted by: Mohammad S Anwar
' You are given an integer $n > 0.
'
' Write a script to print the count of primes less than $n.
'
' Example 1
' Input: $n = 10
' Output: 4 as in there are 4 primes less than 10 are 2, 3, 5 ,7.
' Example 2
' Input: $n = 15
' Output: 6
' Example 3
' Input: $n = 1
' Output: 0
' Example 4
' Input: $n = 25
' Output: 9

' https://en.wikipedia.org/wiki/Primality_test
function is_prime(n as integer) as boolean
    dim i as integer
    if n=2 or n=3 then
        is_prime=true
    elseif n<=1 or (n mod 2)=0 or (n mod 3)=0 then
        is_prime=false
    else
        i=5
        do while i*i<=n
            if (n mod i)=0 or (n mod (i+2))=0 then
                is_prime=false
                exit function
            end if
            i=i+6
        loop
        is_prime=true
    end if
end function

function next_prime(p as integer) as integer
    if p<2 then
        next_prime=2
    else
        p=p+1
        do while not is_prime(p)
            p=p+1
        loop
        next_prime=p
    end if
end function

function count_primes_below_n(n as integer) as integer
    dim p as integer, count as integer
    count=0
    p=2
    do while p<n
        count=count+1
        p=next_prime(p)
    loop
    count_primes_below_n=count
end function

print count_primes_below_n(val(command(1)))
