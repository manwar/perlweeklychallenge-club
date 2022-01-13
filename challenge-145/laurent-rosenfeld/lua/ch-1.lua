#!/usr/bin/lua

local function dot_product(a1, a2)
    res = 0
    for i, v in next, a1 do
        res = res + v * a2[i]
    end
    return res
end

print(dot_product({1, 2, 3}, {4, 5, 6}))
