
function gcd(x, y)
	if (y == 0) then
		return x
	else 
		return gcd(y, x%y)
	end
end

function Equal_group(x)
    
    local set ={}


    for i,v in ipairs(x) do
        set[v]=true
    end
    local res = {}
    for i,v in pairs(set) do
    --  print(i)
        local res_=0
        for _,w in ipairs(x) do
            if i==w then
            res_ =res_+ 1
            end
        end
        table.insert(res,res_)  
    end


    local dummy=0
    local valid = true
    for i=2,#res do
	    -- gcd for each pair
		dummy= gcd(res[i-1],res[i])
    --print (dummy)
	-- if gcd<=1 then failure
    if dummy <= 1 then
            valid = false
    end
    if valid == false then break end
    end

    print(valid)
end

local inputs = { {1,1,2,2,2,2},{1,1,1,2,2,2,3,3}, {5,5,5,5,5,5,7,7,7,7,7,7},{1,2,3,4},{8,8,9,9,10,10,11,11} }

for i=1,#inputs do
    Equal_group(inputs[i])
end
