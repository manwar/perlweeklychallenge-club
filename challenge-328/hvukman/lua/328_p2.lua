
function Bad (a)
local new_str = ""
local need = false
for i = 1, string.len(a)-1 do
    local char = string.sub(a, i, i)
    local char_next = string.sub(a, i+1, i+1)
    
    if string.match(char, "%u") and string.match(char_next, "%l") then
        if char == string.lower(char_next) then

            local new = {}
            for j = 0,string.len(a) do
                if j ~= i and j~= i+1 then
                  
                    table.insert(new,string.sub(a, j, j))
                end 
            end
            new_str = table.concat(new)
           -- print ("maybe not here ", new_str)
            need= true
            break
        end
    
    elseif string.match(char, "%l") and string.match(char_next, "%u") then
        if string.upper(char) == char_next then
            local new = {}
            for j = 0,string.len(a) do
                if j ~= i and j~= i+1 then
                  
                    table.insert(new,string.sub(a, j, j))
                end 
            end
            new_str = (table.concat(new))
            --print ("maybe not ", new_str)
            need=true
            break
            
        end
    end
    
    
end
    -- print ("new " , new_str)
    if need  then
        Bad(new_str)
    else
        print(a)
    end
end


Bad("WeEeekly")
Bad("abc")
Bad("abBAdD")
