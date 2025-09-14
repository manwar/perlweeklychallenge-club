local function max_distance(x,y)

    local distances = {}

    for i=1,#x do
        local distance_ = {}
        for j=1,#y do
            table.insert(distance_,math.abs(x[i]-y[j])) 
        end
        table.sort(distance_)
        table.insert(distances,distance_[#distance_])
    end
    table.sort(distances)
    print(distances[#distances])
end

local inputs = {{{4, 5, 7},{9, 1, 3, 4}} ,
                { {2, 3, 5, 4},{3, 2, 5, 5, 8, 7} },
                { {2, 1, 11, 3} , {2, 5, 10, 2}},
                {{1,2,3},{3,2,1}},
                {{1,0,2,3},{5,0}} 
                }

for _,v in ipairs(inputs) do
    max_distance(v[1],v[2])
end



