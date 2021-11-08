#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

function shortest_path (matrix, from, to, exclude) 
    if (1 + #exclude == #matrix) then
        return matrix [from] [to], {to}
    end

    local shortest = 10 ^ 999   -- Should be big enough...
    local sh_path  = {}
    local new_exclude = {}
    for k, v in pairs (exclude) do
        new_exclude [k] = v
    end
    new_exclude [from] = 1

    local next
    for next = 1, #matrix do
        if next == from or next == to or new_exclude [next] == 1 then
            goto end_loop
        end

        local length
        local path
        length, path = shortest_path (matrix, next, to, new_exclude)
        if  shortest > length + matrix [from] [next] then
            shortest = length + matrix [from] [next]
            sh_path = {}
            sh_path [1] = next
            for k, v in pairs (path) do
                sh_path [k + 1] = v
            end
        end
        ::end_loop::
    end

    return shortest, sh_path
end


matrix = {}

for line in io . lines () do
    row = {}
    for d in line : gmatch ("%d+") do
        table . insert (row, d)
    end
    table . insert (matrix, row)
end


local length
local path
length, path = shortest_path (matrix, 1, 1, {})

print (length)
io . write ("0")
for i = 1, #path do
    io . write (" ")
    io . write (path [i] - 1)
end
print ("")
