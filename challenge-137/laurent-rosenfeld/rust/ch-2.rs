function is_lychrel(n)
    m = n
    for k =1, 500 do
        if n > 10000000 then
            return string.format("%s is a Lychrel candidate. Reached the 1e7 limit", m)
        end
        rev = tonumber(string.reverse(tostring(n)))
        if n == rev then return 0 end
        n = n + rev
    end
    return string.format("%s is a lychrel candidate (made 500 iterations)", m);
end

for key, test in ipairs({10, 20, 30, 50, 100, 196}) do
    print(test, " -> ", is_lychrel(test))
end
