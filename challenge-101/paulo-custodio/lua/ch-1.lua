#!/usr/bin/env lua

--[[
Challenge 101

TASK #1 › Pack a Spiral
Submitted by: Stuart Little

You are given an array @A of items (integers say, but they can be anything).

Your task is to pack that array into an MxN matrix spirally counterclockwise, 
as tightly as possible.

‘Tightly’ means the absolute value |M-N| of the difference has to be as small 
as possible.
--]]

-- find out m,n
function smallest_rect(n)
    local low = 1
    local high = n
    for i=1, math.floor(math.sqrt(n)) do
        if math.floor(math.fmod(n, i)) == 0 then
            low, high = i, math.floor(n/i)
        end
    end
    return low, high
end

-- find max width of elements, convert to int
function max_width(numbers)
    local num_width = 1
    for i=1, #numbers do
        if #numbers[i] < num_width then
            num_width = #numbers[i]
            numbers[i] = tonumber(numbers[i])
        end
    end
    return num_width
end

-- build empty rectangle
function build_empty_rectangle(m, n)
    local rect = {}
    for r=1, m do
        rect[r] = {}
        for c=1, n do 
            rect[r][c] = ""
        end
    end
    return rect
end

-- build spiral rectangle
function spiral(numbers)
    local m, n = smallest_rect(#numbers)
    local num_width = max_width(numbers)
    local rect = build_empty_rectangle(m, n)
    local r, c = m, 1
    local i = 1
    while i <= #numbers do
        -- go East
        while c <= n do
            if rect[r][c] ~= "" then break end
            rect[r][c] = string.format("%"..tostring(num_width+1).."d",
                                       numbers[i])
            i = i + 1
            c = c + 1
        end
        c = c - 1 
        r = r - 1
        -- go North
        while r >= 1 do
            if rect[r][c] ~= "" then break end
            rect[r][c] = string.format("%"..tostring(num_width+1).."d",
                                       numbers[i])
            i = i + 1
            r = r - 1
        end
        r = r + 1 
        c = c - 1
        -- go West
        while c >= 1 do
            if rect[r][c] ~= "" then break end
            rect[r][c] = string.format("%"..tostring(num_width+1).."d",
                                       numbers[i])
            i = i + 1
            c = c - 1
        end
        c = c + 1 
        r = r + 1
        -- go South
        while r <= m do
            if rect[r][c] ~= "" then break end
            rect[r][c] = string.format("%"..tostring(num_width+1).."d",
                                       numbers[i])
            i = i + 1
            r = r + 1
        end
        r = r - 1 
        c = c + 1
    end
    
    -- print result
    for r=1, m do
        for c=1, n do 
            io.write(rect[r][c])
        end
        io.write("\n")
    end
end

spiral(arg)
