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

function eertree(str)
   pal={}
   q={}
   for i = 1,#str do
      for j = i,#str do
         strpal=string.sub(str,i,j)
         strrev=string.reverse(strpal)
         if strpal == strrev and q[strpal] == nil then
            table.insert(pal,strpal)
            q[strpal]=true
         end
      end
   end
   return pal
end

if recursive_compare(eertree("redivider"),{"r","redivider","e","edivide","d","divid","i","ivi","v"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(eertree("deific"),{"d","e","i","ifi","f","c"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(eertree("rotors"),{"r","rotor","o","oto","t","s"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(eertree("challenge"),{"c","h","a","l","ll","e","n","g"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(eertree("champion"),{"c","h","a","m","p","i","o","n"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(eertree("christmas"),{"c","h","r","i","s","t","m","a"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")
