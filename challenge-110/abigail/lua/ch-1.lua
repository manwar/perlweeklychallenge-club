#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local number = line : gsub (" ", "")   -- Remove spaces
    if                   -- nnnn nnnnnnnnnn
          number : find ("^[0-9][0-9][0-9][0-9][0-9][0-9][0-9]"   ..
                          "[0-9][0-9][0-9][0-9][0-9][0-9][0-9]$") or
                         -- +nn  nnnnnnnnnn
          number : find ("^%+[0-9][0-9][0-9][0-9][0-9]"           ..
                          "[0-9][0-9][0-9][0-9][0-9][0-9][0-9]$") or
                         -- (nn) nnnnnnnnnn
          number : find ("^%([0-9][0-9]%)[0-9][0-9][0-9]"         ..
                          "[0-9][0-9][0-9][0-9][0-9][0-9][0-9]$")
    then  print (line)
    end
end
