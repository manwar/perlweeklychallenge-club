local f = function(n) return n + 2 end
local g = function(n) return n * 2 end

local function compose(f, g)
   return function(n)
      return f(g(n))
   end
end

print(compose(f,g)(5))
