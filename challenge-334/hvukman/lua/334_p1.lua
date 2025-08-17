
local ints = {-2,0,3,-5,2,-1}
local point = {0,2}



function Sum(x)
    local points = x[1]
    local index = x[2]
    local sum = 0

    for i= index[1]+1,index[2]+1 do
        sum = sum + points[i]
    end
    print(sum)

end

local input = { {{-2,0,3,-5,2,-1},{0,2}}, {{1, -2, 3, -4, 5}, {1,3}}, {{1, 0, 2, -1, 3},{3,4}}
, {{-5, 4, -3, 2, -1, 0},{0,3}}, {{-1, 0, 2, -3, -2, 1},{0,2}} }

for _,v in ipairs(input) do
    Sum(v)
end
