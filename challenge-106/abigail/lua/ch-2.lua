#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

-- 
-- For explaination of the method below, see ../README.md
--

function long_division (numerator, denominator)
    local BASE     = 10
    local fraction = math . floor (numerator / denominator) .. "."
    local position = fraction : len ()
    local seen     = {}

    numerator = numerator % denominator

    while (not seen [numerator]) do
        if   numerator == 0
        then return (fraction)
        end
        seen [numerator] = position;
        fraction  = fraction .. math . floor (BASE * numerator / denominator)
        numerator =                           BASE * numerator % denominator
        position  = position + 1
    end

    return (fraction : sub (1,  seen [numerator]) .. '(' ..
            fraction : sub (1 + seen [numerator]) .. ')')

end

for line in io . lines () do
    local _, _, numerator, denominator = line : find ("(%d+)%s+(%d+)")
    print (long_division (numerator, denominator))
end
