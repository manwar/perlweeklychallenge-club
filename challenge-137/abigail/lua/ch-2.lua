#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function reverse (num)
    local rev = 0
    while num > 0 do
        rev = rev * 10
        rev = rev + (num % 10)
        num = math . floor (num / 10)
    end
    return (rev)
end


function ly (n)
    if     n >= 10000000
    then   return (1)
    elseif n == reverse (n)
    then   return (0)
    else   return (ly (n + reverse (n)))
    end
end


for number in io . lines () do
    print (ly (tonumber (number)))
end
