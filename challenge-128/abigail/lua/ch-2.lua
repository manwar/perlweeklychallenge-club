#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--


--
-- Read the input, and convert it to minutes (from midnight)
--

local arrivals   = {}
local departures = {}

for hour, minute in io . read ("*l") : gmatch ("([0-9][0-9]):([0-9][0-9])") do
    arrivals   [#arrivals   + 1] = 60 * tonumber (hour) + tonumber (minute)
end
for hour, minute in io . read ("*l") : gmatch ("([0-9][0-9]):([0-9][0-9])") do
    departures [#departures + 1] = 60 * tonumber (hour) + tonumber (minute)
end

--
-- Initialize the trains array, which counts the number of trains
-- in the station on each minute of the day.
--
local trains = {}
for i = 0, 24 * 60 - 1 do
    trains [i] = 0
end

--
-- Process each train
--
for i, arrival in ipairs (arrivals) do
    local departure = departures [i]
    if arrival < departure then
        for i = arrival, departure do
            trains [i] = trains [i] + 1
        end
    else
        for i = 0, arrival do
            trains [i] = trains [i] + 1
        end
        for i = departures, 24 * 60 - 1 do
            trains [i] = trains [i] + 1
        end
    end
end

--
-- Find the maximum
--
local max = 0
for i, count in ipairs (trains) do
    if max < count then
       max = count
    end
end

--
-- And print it
--
print (max)
