local input = {  { {1,2},{3,1},{2,4},{2,3} },
                {{3, 4}, {2, 3}, {1, 5}, {2, 5}},
                { {2,2},{3,3},{4,4}},
                {{0,1}, {1,0}, {0,2}, {2,0}},
                {{5,6}, {6,5}, {5,4}, {4,5}}
             }
local point = {{3,4},{2,5},{1,1},{0,0},{5,5}}



function Validpoint(X,Y)

        local valid = { } -- put valid points in table
        for i,v in ipairs(X) do
            if v[1]==Y[1] then  
                local point_ = {} 
                point_["point"] = v
                point_["idx"] = i
                table.insert(valid,point_)
            elseif v[2]==Y[2] then
                local point_ = {}
                point_["point"] = v
                point_["idx"] = i
                table.insert(valid,point_)
            end
        end
    
    if #valid==0 then
        print("no point shared: ", -1)
    else
        local closest = {}
        for idx,m in ipairs(valid) do

    
          local min = 0
      
          local input_p = m["point"]
      
          for i=1,2 do
                  min = min + math.abs( input_p[i]-Y[i])
          end
              
          local toinsert = {}
          toinsert["min"] = min
          toinsert["idx"] = m["idx"]
          table.insert( closest, toinsert )
      
          end

          table.sort (closest, function (k1, k2) return k1.min < k2.min end ) -- sorting function for minimum value
          local first = closest[1]["idx"]
  
          print("Closest valid point with index: ", first-1) -- subtract for showing index
  
          if(X[first]) then
               for _,ii in ipairs(X[first]) do
                  io.write(ii," ")
               end
          end
          io.write("\n")
    end

end

for i=1,#input do
    Validpoint(input[i],point[i])
end
