dim i as integer, j as integer, word as string, result as string

i = 1
do while command(i) <> ""
    word = command(i)
    if result <> "" then
        result = result & " "
    end if
    for j = 1 to len(word)
        if mid(word, j, 2) = "()" then
            result = result & "o"
            j = j + 1
        elseif mid(word, j, 4) = "(al)" then
            result = result & "al"
            j = j + 3
        else
            result = result & mid(word, j, 1)
        end if
    next j
    i = i + 1
loop
print result
