#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    --
    -- Extract words and put them into an array, in reverse.
    --
    local words = {}
    for str in string . gmatch (line, "[^%s]+") do
        table . insert (words, 1, str)
    end

    --
    -- Print the words
    --
    io . write (table . concat (words, " "), "\n")
end
