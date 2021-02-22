' Challenge 096
'
' TASK #1 › Reverse Words
' Submitted by: Mohammad S Anwar
' You are given a string $S.
'
' Write a script to reverse the order of words in the given string. The string
' may contain leading/trailing spaces. The string may have more than one space
' between words in the string. Print the result without leading/trailing spaces
' and there should be only one space between words.
'
' Example 1:
' Input: $S = "The Weekly Challenge"
' Output: "Challenge Weekly The"

function join_args() as string
    dim text as string
    dim i as integer

    i = 1
    do while command(i)<>""
        text &= trim(command(i))+" "
        i += 1
    loop
    join_args = trim(text)
end function

sub split_text(words() as string, text as string)
    dim p as integer

    redim preserve words(0)
    text = trim(text)
    p = instr(text, " ")
    do while p > 0
        redim preserve words(ubound(words)+1)
        words(ubound(words)) = left(text, p-1)
        text = trim(mid(text, p+1))
        p = instr(text, " ")
    loop
    'store last segment
    redim preserve words(ubound(words)+1)
    words(ubound(words)) = text
end sub

sub print_reverse(words() as string)
    dim i as integer

    for i = ubound(words) to 1 step -1
        print words(i);" ";
    next i
    print
end sub

dim words() as string
split_text words(), join_args()
print_reverse words()
