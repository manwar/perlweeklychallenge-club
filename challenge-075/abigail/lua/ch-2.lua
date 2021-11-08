#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

for line in io . lines () do
    local heights = {}
    local h, i
    local max_height = 0
    for h in line : gmatch ("%d+") do
        h = tonumber (h)
        table . insert (heights, h)
        if  max_height < h then
            max_height = h
        end
    end

    local max_area = 0
    for h = 1, max_height do
        local max = 0
        local cur = 0
        for i = 1, #heights do
            if heights [i] >= h then
                cur = cur + 1
            else
                if  max < cur then
                    max = cur
                end
                cur = 0
            end
        end

        if  max < cur then
            max = cur
        end

        local area = max * h
        if  max_area < area then
            max_area = area
        end
    end

    print (max_area)
end
