function Nice (a)
    print("string: ", a)
    for i = 1, string.len(a) do
        -- match upper and lower substring
        if string.find(a,string.upper(string.sub(a, i, i))) ~= nil and
         string.find(a,string.lower(string.sub(a, i, i))) ~= nil then
            io.write(string.sub(a, i, i))
        end
    end
    print("")
end

Nice("YaaAho")
Nice("cC")
Nice("A")