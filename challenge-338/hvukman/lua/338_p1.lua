
local function highestrow(x)

    local mat = x

    local highest={}

    for i=1,#mat do
        local sum = 0
        for _,v in ipairs(mat[i]) do
            sum=sum+v
        end    
        table.insert(highest,sum)
    end

    table.sort(highest)
    print(highest[#highest])
end

local inputs = {{ {4,4,4,4},{10,0,0,0},{2,2,2,9} } , 
                { {1, 5},{7, 3},{3, 5}}, 
                { {1, 2, 3},{3,2,1}},
                { {2, 8,7},{7,1,3},{1,9,5}},
                {{10, 20,30},{5,5,5},{0,100,0},{25,25,25}}
               }

for i=1,#inputs do
    highestrow(inputs[i])
end


