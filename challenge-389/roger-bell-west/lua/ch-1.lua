#! /usr/bin/lua

function reordernotes(composer, notes, order)
   local out = {}
   for i = 1, #order do
      table.insert(out, "")
   end
   for i, n in ipairs(order) do
      out[n] = notes[i]
   end
   return { [composer] = out }
end

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

if recursive_compare(reordernotes("Mozart", {"C", "D", "E", "F", "G", "A", "B"}, {7, 1, 6, 2, 5, 3, 4}), { ["Mozart"] = {"D", "F", "A", "B", "G", "E", "C"} }) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(reordernotes("Chopin", {"C", "C#", "D", "D#", "E", "F"}, {6, 5, 4, 3, 2, 1}), { ["Chopin"] = {"F", "E", "D#", "D", "C#", "C"} }) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(reordernotes("Vivaldi", {"A", "B", "C", "D", "E"}, {1, 2, 3, 4, 5}), { ["Vivaldi"] = {"A", "B", "C", "D", "E"} }) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(reordernotes("Debussy", {"C", "D", "F", "G", "A"}, {1, 3, 5, 2, 4}), { ["Debussy"] = {"C", "G", "D", "A", "F"} }) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if recursive_compare(reordernotes("Stravinsky", {"C#"}, {1}), { ["Stravinsky"] = {"C#"} }) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

