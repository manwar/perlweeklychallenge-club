local inp = {{ "bella", "label", "roller" }, { "cool", "lock", "cook" } , { "hello", "world", "pole"}
    , { "abc", "def", "ghi" }, { "aab", "aac", "aaa"}}


function Common(X) 
    local unique = {}


    for i,v in ipairs(X) do
        for j=1,#v do
            local sub = string.sub(v,j,j)
            unique[sub] = true
        end
    end


    local res = {}
    io.write ("Output: ")
    -- check each unique character
    for i,_ in pairs(unique) do
        local res = {}
        for _,v in ipairs(X) do
           
            local sum =0
            for index in (v):gmatch(i) do
                sum = sum + 1
              --  print("index ", index)
            end
            if sum>0 then
                table.insert(res,sum)
            end
        end
        
        if #res==3 then
            table.sort(res)
           
            for jj=1,res[1] do
                io.write (i," ")
            end
         
        end
      
    end
      print("") 
end

for i,v in ipairs(inp) do
    Common(v)
   
end
