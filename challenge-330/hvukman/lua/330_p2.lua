function TitleCapital (a)
    words = {}
    for word in a:gmatch("%w+") do 
        table.insert(words, word) 
    end
    for i,v in ipairs(words) do
        if string.len(v)>2 then
            local char = string.sub(v, 1, 1)
            io.write(string.upper(char))
            for i = 2, string.len(v) do
                local sub_char = string.sub(v, i, i)
                io.write(string.lower(sub_char))
            end
        else
            for i = 1, string.len(v) do
                local sub_char = string.sub(v, i, i)
                io.write(string.lower(sub_char))
            end
        end
        io.write(" ")
    end

end

TitleCapital("PERL IS gREAT")