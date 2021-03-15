#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    --
    -- Parse input
    --
    local _, _, hour, minute, ampm = line : find ("(%d+):(%d+)%s*([ap]?)m?")

    --
    -- We need an explicite case to numbers
    --
    hour   = tonumber (hour)
    minute = tonumber (minute)

    --
    -- Find out what the new AM/PM marker should be:
    --   - If the current marker is AM or PM, the new one is empty.
    --   - Else, if the hour is 12 or higher, it's PM
    --   - Else, it's AM
    --
    local new_ampm = ""
    if   ampm == ""
    then if   hour >= 12
         then new_ampm = "pm"
         else new_ampm = "am"
         end
    end

    --
    -- Calculate the new hours
    --   - If AM, an hour of 12 becomes 0, and we leave the rest as is
    --   - If PM, an hour of 12 stays 12, else, we add 12 to the hour
    --   - If no AM/PM, subtract 12 if the hour is larger than 12;
    --        add 12 if the hour is 0
    --
    hour = hour % 12
    if   ampm == "" and hour == 0
    then hour = 12
    end
    if   ampm == "p"
    then hour = hour + 12
    end

    --
    -- Print the results
    --
    print (string . format ("%02d:%02d%s", hour, minute, new_ampm))
end
