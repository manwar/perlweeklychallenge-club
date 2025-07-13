
function counting (X)
print("string: ", X)
local ints = {}
-- store values as keys which are unique
for word in string.gmatch(X, "%d+") do 
    ints[word]= true
end
-- print keys
 for i,v in pairs(ints) do
            print (i)
        end
    end

counting("the1weekly2challenge2")
counting("go21od1lu5c7k")
counting("4p3e2r1l")
