#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local NR_OF_DIGITS = 10

for line in io . lines () do

    -- 
    -- Process the input, count digits
    --
    local digits = {}
    for i = 0, NR_OF_DIGITS - 1
    do  digits [i] = 0
    end
    for d in line : gmatch ("%d")
    do  d = tonumber (d)
        digits [d] = digits [d] + 1
    end

    -- 
    -- Find the lowest even digit
    --
    local last = -1
    for i = NR_OF_DIGITS - 2, 0, -2
    do  if   digits [i] > 0
        then last = i
        end
    end

    --
    -- Skip if there is no even digit in the input
    --
    if   last < 0
    then goto end_loop
    end

    digits [last] = digits [last] - 1

    --
    -- Create output: digits from high to low
    --
    local out = ""
    for i = NR_OF_DIGITS - 1, 0, -1
    do  for j = 1, digits [i]
        do  out = out .. tostring (i)
        end
    end

    print (out .. tostring (last))

    ::end_loop::
end
