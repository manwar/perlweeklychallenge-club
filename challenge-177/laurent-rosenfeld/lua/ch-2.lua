local function is_cyclops(num)
    local n_str = tostring(num)
    size = string.len(n_str)
    if size % 2 == 0 then
        return false
    end
    mid = (size + 1) / 2
    if string.sub(n_str, mid, mid ) ~= '0' then
        return false
    end
    if string.sub(n_str, 1, mid-1):find "0" ~= nil then
        return false
    end
    if string.sub(n_str, mid+1, len):find "0" ~= nil then
        return false
    end
    return true
end

local function is_prime(n)
    if n == 2 then
        return true
    end
    if n < 2 or n % 2 == 0 then
        return false
    end
    local p = 3
    sqrt_n = math.sqrt(n)
    while p <= sqrt_n do
        if n % p == 0 then
            return false
        end
        p = p + 2
    end
    return true
end

count = 0
i = 100
while count < 20 do
    i = i + 1
    if i == 999 then
        i = 10000
    elseif i == 99999 then
        i = 1000000
    elseif i >= 9999999 then
        break
    end

    if i ~= tonumber(string.reverse(tostring(i))) then
        goto skip
    end
    if not is_cyclops(i) then
        goto skip
    end
    if is_prime(i) then
        io.write(i, " ")
        count = count + 1
    end
    ::skip::
end
print("")
