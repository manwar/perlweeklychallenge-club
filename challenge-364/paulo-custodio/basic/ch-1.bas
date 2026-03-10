function encode_word(word as string) as string
    dim i as integer, c as string, num as string, result as string

    for i = 1 to len(word)
        c = mid(word, i, 1)
        if c >= "a" and c <= "z" then
            num = trim(str(asc(c) - asc("a") + 1))
            if len(num) > 1 then
                result = result & num & "#"
            else
                result = result & num
            end if
        end if
    next i

    encode_word = result
end function

function decode_word(word as string) as string
    dim i as integer, result as string

    for i = 1 to len(word)
        if i+2 <= len(word) and mid(word, i+2, 1) = "#" then
            result = result & chr(val(mid(word, i, 2)) + asc("a") - 1)
            i = i + 2
        else
            result = result & chr(val(mid(word, i, 1)) + asc("a") - 1)
        end if
    next i

    decode_word = result
end function

dim result as string
dim encode as integer, i as integer

i = 1
do while command(i) <> ""
    if command(i) = "-e" then
        encode = 1
    elseif command(i) <> "" then
        if result <> "" then
            result = result & " "
        end if
        if encode then
            result = result & encode_word(command(i))
        else
            result = result & decode_word(command(i))
        end if
    end if
    i = i + 1
loop
print result
