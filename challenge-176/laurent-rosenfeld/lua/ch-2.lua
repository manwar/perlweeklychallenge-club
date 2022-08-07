local function is_reversible(n)
    rev = tonumber(string.reverse(tostring(n)))
    sum = rev + n
    while sum > 0 do
        if sum % 2 == 0 then
            return false
        end
        sum = math.floor(sum / 10)
    end
    return true
end

for i = 1, 100 do
    if is_reversible(i) then
        io.write(i, " ")
    end
end
print("")
