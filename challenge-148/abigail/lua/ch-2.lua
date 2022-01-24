#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
--

--
-- Run as: lua ch-2.lua
--

local COUNT = 5
local A     = 0
local B     = 1
local C     = 2
local SUM   = 3
local out   = {}
for i = 1, COUNT do
    out [i] = {}
    out [i] [A]   = 999999
    out [i] [B]   = 999999
    out [i] [C]   = 999999
    out [i] [SUM] = out [i] [A] + out [i] [B] + out [i] [C]
end

local k         = 0
local max_index = 1

while 3 * k + 2 <= out [max_index] [SUM] do
    local a  = 3 * k + 2
    local f1 =     k + 1
    local f2 = 8 * k + 5

    --
    -- Find divisors of f1
    --
    local d1 = {}
    local i = 0
    while i * i <= f1 do
        if f1 % i == 0 then
            d1 [#d1 + 1] = i
            if f1 / i ~= i then
                d1 [#d1 + 1] = f1 / i
            end
        end
        i = i + 1
    end

    local d2 = {}
    i = 0
    while i * i <= f2 do
        if f2 % i == 0 then
            local s1 = math . floor (math . sqrt (i))
            local s2 = math . floor (math . sqrt (f2 / i))
            if s1 * s1 == i then
                d2 [#d2 + 1] = s1
            end
            if s2 * s2 == f2 / i and s1 ~= s2 then
                d2 [#d2 + 1] = s2
            end
        end
        i = i + 1
    end

    local d1v
    local d2v

    for _, d1v in ipairs (d1) do
        for _, d2v in ipairs (d2) do
            local b = d1v * d2v
            local c = f1 * f1 * f2 / (b * b)
            if (a + b + c) < out [max_index] [SUM] then
                local i
                for i = 1, COUNT do
                    if out [i] [A] == a and out [i] [B] == b then
                        goto end_loop
                    end
                end

                out [max_index] [A]   = a
                out [max_index] [B]   = b
                out [max_index] [C]   = c
                out [max_index] [SUM] = a + b + c

                --
                -- Find new max_index
                --

                max_index = 1
                local max_sum = out [max_index] [SUM]

                local l
                for l = 2, COUNT do
                    if max_sum < out [l] [SUM] then
                        max_index = l
                        max_sum   = out [l] [SUM]
                    end
                end
            end
            ::end_loop::
        end
    end

    k = k + 1
end

for i = 1, COUNT do
    print (out [i] [A] .. " " .. out [i] [B] .. " " .. out [i] [C])
end

