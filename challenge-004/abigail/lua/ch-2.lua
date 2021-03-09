#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua -f FILE < input-file
--

--
-- Parse option, and exit if incorrect
--

local filename = ""
if   #arg == 2 and arg [1] == "-f"
then filename = arg [2]
end

if   file == ""
then io . stderr : write ("Requires a '-f FILE' option\n")
     os . exit (1)
     end

--
-- Given a file name, and a set of letters, print
-- the words from the file which can be made with the letters.
--
function extract_words (filename, letters)
    for word in io . lines (filename) do
        copy = word : gsub ("\n", "") : lower ()
        for i = 1, letters : len () do
            --
            -- Remove each of the characters of 'letters' from
            -- 'copy', after lowercasing, and only once.
            --
            copy = copy : gsub (letters : sub (i, i) : lower (), "", 1)
        end
        --
        -- If we end up with the empty string, we have a winner.
        --
        if (copy : len () == 0)
        then
            print (word)
        end
    end
end

for line in io . lines () do
    extract_words (filename, line : gsub ("\n", ""))
end
