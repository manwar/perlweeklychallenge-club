#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end

  -- Check each key-value pair
  -- We have to do this both ways in case we miss some.
  -- TODO: Could probably be smarter and not check those we've 
  -- already checked though!
  for k1,v1 in pairs(t1) do
    local v2 = t2[k1]
    if( not recursive_compare(v1,v2) ) then return false end
  end
  for k2,v2 in pairs(t2) do
    local v1 = t1[k2]
    if( not recursive_compare(v1,v2) ) then return false end
  end

  return true  
end

Fraction = {n = 1, b = 1}

function Fraction:new (o)
   o = o or {}
   self.__index = self
   setmetatable(o,self)
   return o
end

function Fraction:get_parent ()
   p=Fraction:new()
   p.n = self.n
   p.d = self.d
   if p.n < p.d then
      p.d = p.d - p.n
   else
      p.n = p.n - p.d
   end
   return p
end

function Fraction:stringify ()
   return string.format("%d/%d",self.n,self.d)
end

function Fraction:set_from_string (s)
   for n, d in string.gmatch(s,"(%d+)/(%d+)") do
      self.n=tonumber(n)
      self.d=tonumber(d)
   end
   return self
end

function p_gp(s)
   f=Fraction:new():set_from_string(s)
   out={}
   for i = 1,2 do
      f=f:get_parent()
      table.insert(out,f:stringify())
   end
   return out
end

if recursive_compare(p_gp("3/5"),{"3/2","1/2"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(p_gp("4/3"),{"1/3","1/2"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")
