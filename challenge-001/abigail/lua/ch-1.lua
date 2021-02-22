--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    line, count = string . gsub (line, "e", "E");
    io . write (line, "\n", count, "\n")
end
