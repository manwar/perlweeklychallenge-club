--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    for i = 1, line do
        if    i % 15 == 0
        then
            out = "fizzbuzz"
        elseif i %  5 == 0
        then
            out =     "buzz"
        elseif i %  3 == 0
        then
            out = "fizz"
        else
            out =  i
        end
        io . write (out, "\n")
    end
end
