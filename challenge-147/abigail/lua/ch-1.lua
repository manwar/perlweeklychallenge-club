#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
--

--
-- Run as: lua ch-1.lua
--

function is_prime (p)
    if p == 2 then
        return true
    end
    if p % 2 == 0 then
        return false
    end
    i = 3
    while i * i <= p do
        if p % i == 0 then
            return false
        end
        i = i + 2
    end
    return true
end

todo = {2, 3, 5, 7}
for i, p in ipairs (todo) do
    io . write (p, " ")
end

count = 20 - #todo

pow = 10
while #todo > 0 do
    new_todo = {}
    for d = 1, 9 do
        for i, p in ipairs (todo) do
            candidate = d * pow + p
            if is_prime (candidate) then
                io . write (candidate, " ")
                new_todo [#new_todo + 1] = candidate
                count = count - 1
                if count <= 0 then
                    goto end_of_while
                end
            end
        end
    end
    todo = new_todo
    pow  = pow * 10
end

::end_of_while::

io . write ("\n")
