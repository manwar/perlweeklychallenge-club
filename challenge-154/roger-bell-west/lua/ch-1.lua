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

function join(t)
   local out=""
   for k,v in pairs(t) do
      out = out .. v
   end
   return out
end

function permute(a)
   local out={}
   local n=#a
   local c={}
   for i = 1,n do
      table.insert(c,1)
   end
   out[join(a)]=true
   local i=1
   while true do
      if i > n then
         break
      end
      if c[i] < i then
         if i % 2 == 1 then
            a[1],a[i] = a[i],a[1]
         else
            a[c[i]],a[i] = a[i],a[c[i]]
         end
         out[join(a)]=true
         c[i]=c[i]+1
         i=1
      else
         c[i] = 1
         i = i+1
      end
   end
   return out
end

function missingpermutations(list)
   perms = {}
   l0={}
   string.gsub(list[1],".",function(c) table.insert(l0,c) end)
   perms=permute(l0)
   out = {}
   plist = {}
   for k,v in pairs(list) do
      plist[v]=true
   end
   for k,v in pairs(perms) do
      if plist[k] == nil then
         table.insert(out,k)
      end
   end
   return out
end

if recursive_compare(missingpermutations({"PELR", "PREL", "PERL",
                                          "PRLE", "PLER", "PLRE",
                                          "EPRL", "EPLR", "ERPL",
                                          "ERLP", "ELPR", "ELRP",
                                          "RPEL", "RPLE", "REPL",
                                          "RELP", "RLPE", "RLEP",
                                          "LPER", "LPRE", "LEPR",
                                          "LRPE", "LREP"}),
                     {"LERP"}) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
