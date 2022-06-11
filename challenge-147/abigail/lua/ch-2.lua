#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
--

--
-- Run as: lua ch-2.lua
--

pentagon = {}
p = 0
n = 0

while true do
    p = p + n + n + n + 1
    n = n + 1
    pentagon [p] = 1
    for seen in pairs (pentagon) do
        if seen + seen <= p and pentagon [p - seen]        ~= nil
                            and pentagon [p - seen - seen] ~= nil then
            print (seen .. " " .. (p - seen))
            goto end_of_while
        end
    end
end

::end_of_while:: 

