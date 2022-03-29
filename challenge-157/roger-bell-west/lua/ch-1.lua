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

function arithmeticmean(s)
   local t=0
   for k,v in ipairs(s) do
      t = t + v
   end
   return t / #s
end

function geometricmean(s)
   local t=1
   for k,v in ipairs(s) do
      t = t * v
   end
   return t ^ (1/#s)
end

function harmonicmean(s)
   local t=0
   for k,v in ipairs(s) do
      t = t + 1/v
   end
   return #s / t
end

function round1(x)
   return math.floor(10*x+0.499999)/10
end

function pythagoreanmeans(s)
   return { AM = round1(arithmeticmean(s));
            GM = round1(geometricmean(s));
            HM = round1(harmonicmean(s)) }
end

if recursive_compare(pythagoreanmeans({1,3,5,7,9}),
                     { AM = 5.0; GM = 3.9; HM = 2.8 }) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(pythagoreanmeans({2,4,6,8,10}),
                     { AM = 6.0; GM = 5.2; HM = 4.4 }) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if recursive_compare(pythagoreanmeans({1,2,3,4,5}),
                     { AM = 3.0; GM = 2.6; HM = 2.2 }) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
