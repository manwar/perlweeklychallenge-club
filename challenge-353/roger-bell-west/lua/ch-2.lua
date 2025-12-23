#! /usr/bin/lua

-- by Michael Anderson at
-- https://stackoverflow.com/questions/8722620/comparing-two-index-tables-by-index-value-in-lua
-- modified by Roger
function recursive_compare(t1,t2)
  -- Use usual comparison first.
  if t1==t2 then return true end
  -- We only support non-default behavior for tables
  if (type(t1)~="table") then return false end
  -- They better have the same metatables
  local mt1 = getmetatable(t1)
  local mt2 = getmetatable(t2)
  if( not recursive_compare(mt1,mt2) ) then return false end
  -- Build list of all keys
  local kk = {}
  for k1, _ in pairs(t1) do
     kk[k1] = true
  end
  for k2, _ in pairs(t2) do
     kk[k2] = true
  end
  -- Check each key that exists in at least one table
  for _, k in ipairs(kk) do
     if (not recursive_compare(t1[k], t2[k])) then
        return false
     end
  end
  return true
end

function validatecoupon(codes, names, status)
   local dep = { electronics = true,
                 grocery = true,
                 pharmacy = true,
                 restaurant = true, }
   local nx = "^[_%w]+$"
   local out = {}
   for i = 1, #codes do
      table.insert(out,
                   string.match(codes[i], nx) ~= nil and
                   dep[names[i]] ~= nil and
                   status[i])
   end
   return out
end

if recursive_compare(validatecoupon({"A123", "B_456", "C789", "D@1", "E123"}, {"electronics", "restaurant", "electronics", "pharmacy", "grocery"}, {true, false, true, true, true}), {true, false, true, false, true}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(validatecoupon({"Z_9", "AB_12", "G01", "X99", "test"}, {"pharmacy", "electronics", "grocery", "electronics", "unknown"}, {true, true, false, true, true}), {true, true, false, true, false}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(validatecoupon({"_123", "123", "", "Coupon_A", "Alpha"}, {"restaurant", "electronics", "electronics", "pharmacy", "grocery"}, {true, true, false, true, true}), {true, true, false, true, true}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(validatecoupon({"ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"}, {"electronics", "electronics", "grocery", "grocery"}, {true, true, true, true}), {true, true, true, true}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(validatecoupon({"CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"}, {"restaurant", "electronics", "grocery", "pharmacy", "electronics"}, {true, true, true, true, false}), {true, true, true, true, false}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

