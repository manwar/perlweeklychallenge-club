#!/usr/bin/env lua

--[[
Challenge 003

Challenge #2
Create a script that generates Pascal Triangle. Accept number of rows from
the command line. The Pascal Triangle should have at least 3 rows. For more
information about Pascal Triangle, check this wikipedia page.
--]]

function draw_pascal(rows)
    local data = {1}
    for row=1,rows do
        -- print current row
        for col=1,rows-row do io.write(" "); end
        for col=1,row do io.write(data[col], " "); end
        io.write("\n")

        -- compute next row
        local nxt = {1}
        for col=1,row-1 do
            table.insert(nxt, data[col] + data[col+1])
        end
        table.insert(nxt, 1)
        data = nxt
    end
end

draw_pascal(tonumber(arg[1]))
