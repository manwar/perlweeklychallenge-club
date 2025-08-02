function Nice (a)
    local not_good = false
    local new
    for i = 1, string.len(a) do
        local char = string.sub(a, i, i)
        if string.match(char, "%d") then
            new= string.sub(a, 1, i-2) .. string.sub(a, i+1, string.len(a))
            not_good= true
            break
        end

    end
    if not_good==true then
        return Nice(new)
    end
    print(a)
    return a
end

Nice("cab12")
Nice("xy99")
Nice("pa1erl")

