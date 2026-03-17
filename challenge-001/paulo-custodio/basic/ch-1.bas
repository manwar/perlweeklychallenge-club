' Perl Weekly Challenge 001 - Task 1 - solution by Paulo Custodio
' https://theweeklychallenge.org/blog/perl-weekly-challenge-001/

function replace_e(byref text as string) as integer
    dim i as integer, count as integer
    for i=1 to len(text)
        if mid(text,i,1)="e" then
            text = left(text, i-1) & "E" & mid(text, i+1)
            count = count+1
        end if
    next i
    replace_e = count
end function

function join_args() as string
    dim i as integer, sep as string, result as string
    sep = ""
    i = 1
    do while command(i)<>""
        result = result & sep & command(i)
        sep = " "
        i = i+1
    loop
    join_args = result
end function

dim text as string
text = join_args()
print replace_e(text);" ";text
