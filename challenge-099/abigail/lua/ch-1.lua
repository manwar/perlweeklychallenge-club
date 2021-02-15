#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    --
    -- Extract the string and pattern
    --
    local str, pattern = line : match ("(%S+) +(%S+)")

    --
    -- Turn the pattern into a Lua pattern, replace any
    -- character c:
    --    if c == "?"             ->  .
    --    if c == "*"             ->  .*
    --    if c is not an alpanum  -> %c
    --    otherwise, keep c as is
    -- And then add anchors
    --
    pattern = pattern : gsub (".", function (c)
        local result = c
        if c == "?" then
            result = "."
        elseif c == "*" then
            result = ".*"
        elseif c : match ("%W") then
            result = "%" .. c
        end
        return result
    end)
    pattern = "^" .. pattern .. "$"

    --
    -- Print 1/0 depending whether we have a match or not.
    --
    if (str : match (pattern)) then
        print (1)
    else 
        print (0)
    end
end
