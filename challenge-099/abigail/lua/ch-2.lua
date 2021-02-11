#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

-- 
-- Recursively count matches:
--   - If either the string or the pattern is empty, there are no matches.
--   - Else, + count the matches if we don't match at the first character
--             if the string.
--           + if the first character of the string equals the first
--             character of the pattern:
--             o  add 1 if the pattern is just one character long
--             o  else, add the number of matches starting from the
--                then next character in the string, and the next
--                character in the pattern.
--
function matches (str, pattern)
    if  str : len () == 0  or  pattern : len () == 0  then
        return 0
    end

    local count = matches (str : sub (2), pattern)
    if  str : sub (1, 1) == pattern : sub (1, 1) then
        if  pattern : len () == 1 then
            count = count + 1
        else 
            count = count + matches (str : sub (2), pattern : sub (2))
        end
    end
    return (count)
end


--
-- Read input from standard input, assuming one exercise per line.
-- Each line consists of a string $S, and a pattern $T, separated
-- by whitespace.
--
for line in io . lines () do
    local str, pattern = line : match ("(%S+) +(%S+)")
    print (matches (str, pattern))
end
