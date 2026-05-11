
local function largest_substring(x)
    local tab = {}
    local res = {}

    -- insert characters as keys
    for i=1,#x do
        tab[string.sub(x,i,i)] = true
    end

    local max_dist = 0

    for i,_ in pairs(tab) do
        for ii=1,(#x//2+1) do 
            for j = #x, ii + 1, -1 do  
            
                if string.sub(x,ii,ii) == i and string.sub(x,j,j) == i  then
                    if j-ii-1 > max_dist then
                        max_dist = j-ii-1
                    end
                end
            end
        
        end
    end

    print(max_dist)
end


for _,v in ipairs{"aaaaa","abcdeba","abbc","abcaacbc","laptop" } do
    largest_substring(v)
end
