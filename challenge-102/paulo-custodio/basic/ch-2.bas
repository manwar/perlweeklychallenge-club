' Challenge 102
'
' TASK #2 › Hash-counting String
' Submitted by: Stuart Little
'
' You are given a positive integer $N.
'
' Write a script to produce Hash-counting string of that length.
'
' The definition of a hash-counting string is as follows:
' - the string consists only of digits 0-9 and hashes, ‘#’
' - there are no two consecutive hashes: ‘##’ does not appear in your string
' - the last character is a hash
' - the number immediately preceding each hash (if it exists) is the position
' of that hash in the string, with the position being counted up from 1
'
' It can be shown that for every positive integer N there is exactly one such
' length-N string.
' Examples:
'
' (a) "#" is the counting string of length 1
' (b) "2#" is the counting string of length 2
' (c) "#3#" is the string of length 3
' (d) "#3#5#7#10#" is the string of length 10
' (e) "2#4#6#8#11#14#" is the string of length 14

function hash_count(n as Integer) as String
    Dim res as String, i as Integer, p as Integer
    i = n
    do while i>0
        p = i
        res = "#" & res
        i = i-1
        do while i>0 and p<>0
            res = chr(asc("0") + (p mod 10)) & res
            p = int(p / 10)
            i = i-1
        loop
    loop
    hash_count = res
end function

'main
print hash_count(val(Command(1)))
