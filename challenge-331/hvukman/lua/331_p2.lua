-- http://lua-users.org/wiki/CopyTable 
-- Deepcopy of table
function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end


-- turn word to table and then swap it
function Swap(Table, Pos1, Pos2)
    -- deep copy of table and then return it
    local new_tab = deepcopy(Table)
    new_tab[Pos1], new_tab[Pos2] = new_tab[Pos2], new_tab[Pos1]
    return new_tab
end

local word = {}
local inp = "feed"
local buddy = "feed"

for i= 1,#inp do
    table.insert(word,string.sub(inp,i,i))
end

local isbuddy = false 
for j= 1,#word-1 do
    local newword = (table.concat(Swap(word,j,j+1)))
    -- print (newword)
    if newword == buddy then
        print ("buddy: ", newword)
        print("true")
        isbuddy = true
        break
    end
    
end

if (not isbuddy) then
        print("false")
end