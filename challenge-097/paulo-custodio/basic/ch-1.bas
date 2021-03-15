' Challenge 097
'
' TASK #1
'
' TASK #1 › Caesar Cipher
' Submitted by: Mohammad S Anwar
' You are given string $S containing alphabets A..Z only and a number $N.
'
' Write a script to encrypt the given string $S using Caesar Cipher with left
' shift of size $N.
'
' Example
' Input: $S = "THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG", $N = 3
' Output: "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD"
'
' Plain:    ABCDEFGHIJKLMNOPQRSTUVWXYZ
' Cipher:   XYZABCDEFGHIJKLMNOPQRSTUVW
'
' Plaintext:  THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG
' Ciphertext: QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD

function caeser(n as integer, text as string) as string
    dim i as integer, cipher as string
    dim c as integer

    for i=1 to len(text)
        if mid(text,i,1)>="A" and mid(text,i,1)<="Z" then
            c = ((asc(mid(text,i,1))-asc("A")+26-n) mod 26)+asc("A")
            cipher = cipher & chr(c)
        else
            cipher = cipher & mid(text,i,1)
        end if
    next i
    caeser = cipher
end function

' main
dim text as string
dim n as integer, i as integer
n = val(command(1))
i = 2: do while command(i)<>"": text = text & command(i) & " ": i=i+1: loop

print caeser(n, text)
