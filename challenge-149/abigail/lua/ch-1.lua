#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-149
--

--
-- Run as: lua ch-1.lua < input-file
--

function digit_sum (number)
    local sum = 0
    while number > 0 do
        sum = sum + number % 10
        number = math . floor (number / 10)
    end
    return (sum)
end

fib            = {}
fib_prev       = 0
fib_last       = 1
fib [fib_prev] = 1
fib [fib_last] = 1

function is_fib (n)
    while fib_last < n do
        local t  = fib_last
        fib_last = fib_last + fib_prev
        fib_prev = t
        fib [fib_last] = 1
    end

    return fib [n]
end


for n in io . lines () do
    n = tonumber (n)
    k = 0
    while n > 0 do
        if is_fib (digit_sum (k)) then
            io . write (k .. " ")
            n = n - 1
        end
        k = k + 1
    end
    print ("")
end
