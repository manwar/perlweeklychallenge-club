
local function arrayfromcompute(ints,x)

    local str = ""

    for i,v in ipairs(ints) do
        str = str .. v
    end

    str = tostring(tonumber(str) + x )
    local empty = {}

    for i=1,#str do
        table.insert(empty,string.sub(str,i,i))
    end

    for i,v in ipairs(empty) do
        io.write(v," ")
    end
    io.write('\n')
end


arrayfromcompute({1,2,3,4},12)
arrayfromcompute({2,7,4},181)
arrayfromcompute({9,9,9},1)
arrayfromcompute({1,0,0,0,0},9999)
arrayfromcompute({0},1000)

