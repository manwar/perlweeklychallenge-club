#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

--
-- This is an implementation of the Wagner Fischer algorithm, which
-- calculates the Levenshtein distance.
--
-- See https://en.wikipedia.org/wiki/Wagner%E2%80%93Fischer_algorithm
--
function LevenshteinDistance (first, second)
    local n = first  : len ()
    local m = second : len ()
    distance = {}
    for i = 0, n do
        distance [i] = {}
        for j = 0, m do
            if i == 0 or j == 0
            then
                distance [i] [j] = i + j
            else
                local cost = 1
                if string . sub (first,  i, i) ==
                   string . sub (second, j, j)
                then
                    cost = 0
                end
                distance [i] [j] = math . min (
                    distance [i - 1] [j]     + 1,
                    distance [i]     [j - 1] + 1,
                    distance [i - 1] [j - 1] + cost
                )
            end
        end

        --
        -- We only need the previous row, so we can return the
        -- memory of rows before that. This reduces the memory
        -- usage from Theta (n * m) to O (n + m)
        --
        if i > 0
        then
            distance [i - 1] = nil
        end
    end
    return distance [n] [m]
end


for line in io . lines () do
    --
    -- Extract words and put them into an array.
    --
    local words = {}
    index = 0
    for str in string . gmatch (line, "[^ ]+") do
        index = index + 1
        words [index] = str
    end

    --
    -- Calculate the edit distance, and print the result.
    --
    io . write (LevenshteinDistance (words [1], words [2]), "\n")
end
