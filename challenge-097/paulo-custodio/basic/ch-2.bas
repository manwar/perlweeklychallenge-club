' Challenge 097
'
' TASK #2 › Binary Substings
' Submitted by: Mohammad S Anwar
' You are given a binary string $B and an integer $S.
'
' Write a script to split the binary string $B of size $S and then find the
' minimum number of flips required to make it all the same.
'
' Example 1:
' Input: $B = “101100101”, $S = 3
' Output: 1
'
' Binary Substrings:
'     "101": 0 flip
'     "100": 1 flip to make it "101"
'     "101": 0 flip
' Example 2:
' Input $B = “10110111”, $S = 4
' Output: 2
'
' Binary Substrings:
'     "1011": 0 flip
'     "0111": 2 flips to make it "1011"

function str_flips(a as string, b as string) as integer
    dim i as integer, flips as integer

    for i=1 to len(a)
        if mid(a,i,1)<>mid(b,i,1) then flips=flips+1
    next i

    str_flips=flips
end function

function bit_flips(bits as string, n as integer) as integer
    dim i as integer, flips as integer

    for i=n+1 to len(bits) step n
        flips=flips+str_flips(left(bits,n), mid(bits,i,n))
    next i

    bit_flips=flips
end function

print trim(str(bit_flips(command(1), val(command(2)))))
