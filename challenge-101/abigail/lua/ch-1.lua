#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local RIGHT = 0
local UP    = 1
local LEFT  = 2
local DOWN  = 3

--
-- Read in the input: a single line, with the elemens separated by white space
--
local line = io . read ()
local elements = {}
for element in line : gmatch ("%S+") do
    elements [#elements + 1] = element
end

--
-- Calculate the optimal width and height
--
local height = math . floor (math . sqrt (#elements))
while #elements % height > 0 do
    height = height - 1
end
local width = #elements / height

--
-- Fill the matrix, starting from the bottom left
--
local min_x     = 1
local max_x     = height
local min_y     = 1
local max_y     = width
local x         = max_x
local y         = min_y
local direction = RIGHT

--
-- Initialize the matrix
--
local matrix = {}
for x = 1, height do
    matrix [x] = {}
end

for i = 1, #elements do
    matrix [x] [y] = elements [i]
    local turn = 0

    if   direction == RIGHT
    then if   y >= max_y
         then turn =  1
              x = x - 1
              max_x = max_x - 1
         else y = y + 1
         end
    end

    if   direction == UP
    then if   x <= min_x
         then turn =  1
              y = y - 1
              max_y = max_y - 1
         else x = x - 1
         end
    end

    if   direction == LEFT
    then if   y <= min_y
         then turn =  1
              x = x + 1
              min_x = min_x + 1
         else y = y - 1
         end
    end

    if   direction == DOWN
    then if   x >= max_x
         then turn =  1
              y = y + 1
              min_y = min_y + 1
         else x = x + 1
         end
    end

    if   turn > 0
    then direction = (direction + 1) % 4
    end

end

--
-- Find the maximum widths in each column
--
local widths = {}
for  y = 1, width
do   local max = 0
     for x = 1, height
     do   if   max < #matrix [x] [y]
          then max = #matrix [x] [y]
          end
     end
     widths [y] = max
end


--
-- Pretty print the matrix
--
for  x = 1, height
do   for  y = 1, width
     do   if   y > 1
          then io . write (" ")
          end
          local format = "%" .. widths [y] .. "s"
          io . write (string . format (format, matrix [x] [y]))
     end
     io . write ("\n")
end
