
   local function permgen (a, n)
      if n == 0 then
        coroutine.yield(a)
      else
        for i=1,n do
          -- put i-th element as the last one
          a[n], a[i] = a[i], a[n]
          -- generate all permutations of the other elements
          permgen(a, n - 1)
          -- restore i-th element
          a[n], a[i] = a[i], a[n]
    
        end
      end
    end


    local function result (a,t)
      local found = {}
      local count = 0
      
      -- a is permutation 
      for _,v in ipairs(a) do
        for _,k in ipairs(v) do
          table.insert(found,k)
        end
      end  
      
      for i=1,#found do
       
        -- if key=value add up
        if found[i]==t[i] then
          count = count + 1
        end
      end
      -- true if all keys equals values
      return count==#t
    end
    
   

   local function perm (a)
      local n = #a
      local co = coroutine.create(function () permgen(a, n) end)
      return function ()   -- iterator
        local code, res = coroutine.resume(co)
        return res
      end
    end



local function arrayform(t,x)

  local search = false

  for p in perm(x) do
        search=(result (p,t))
        if result (p,t)==true then break end
  end

  print(search)

end


arrayform({1,2,3,4},{{2, 3},{1},{4}})
arrayform({1,2,3,4},{{1, 3},{2,4}})
arrayform({5, 8, 2, 9, 1},{{9,1},{5,8},{2}})
arrayform({1,2,3},{{1},{3}})
arrayform({7,4,6},{{7,4,6}})
-- permute dummy
