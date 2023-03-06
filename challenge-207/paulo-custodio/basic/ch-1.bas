' Challenge 207
'
' Task 1: Keyboard Word
' Submitted by: Mohammad S Anwar
'
' You are given an array of words.
'
' Write a script to print all the words in the given array that can be types
' using alphabet on only one row of the keyboard.
'
' Let us assume the keys are arranged as below:
'
' Row 1: qwertyuiop
' Row 2: asdfghjkl
' Row 3: zxcvbnm
'
' Example 1
'
' Input: @words = ("Hello","Alaska","Dad","Peace")
' Output: ("Alaska","Dad")
'
' Example 2
'
' Input: @array = ("OMG","Bye")
' Output: ()

function remove_char(byval s as string, c as string) as string
    dim p as integer

    p=instr(s,c)
    do while p>0
        s=left(s,p-1)+mid(s,p+1)
        p=instr(s,c)
    loop
    remove_char=s
end function

function can_type_word(k as string, byval s as string) as boolean
    dim i as integer
    for i=1 to len(k)
        s=remove_char(s,mid(k,i,1))
    next
    can_type_word=s=""
end function

function can_type(s as string) as boolean
    s=lcase(s)
    can_type=can_type_word("qwertyuiop",s) or _
             can_type_word("asdfghjkl",s) or _
             can_type_word("zxcvbnm",s)
end function

dim i as integer
i=1
do while command(i)<>""
    if can_type(command(i)) then print command(i);" ";
    i=i+1
loop
print
