-- How to run:
-- $ lua ch-1.lua 100
-- 13015

function gcd(a, b)
    while b > 0 do 
        t = b
        b = a % b
        a = t
    end

    return a
end

n = arg[1] and arg[1] or 3

s = 0
for x = 1, n do
    for y = x + 1, n do
        s = s + gcd(x, y)
    end
end

print(s)
