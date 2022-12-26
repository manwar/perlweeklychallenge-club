#! /usr/bin/lua

function is_wigglesorted(l)
   for i = 1, #l-1 do
      if i % 2 == 1 then
         if l[i] >= l[i+1] then
            return false
         end
      else
         if l[i] <= l[i+1] then
            return false
         end
      end
   end
   return true
end

function wigglesort(l)
   local s = l
   table.sort(s)
   local le = #s
   local p = math.floor(le / 2)
   local a = {}
   local b = {}
   for ii, v in ipairs(s) do
      if ii < p  then
         table.insert(a, v)
      else
         table.insert(b, v)
      end
   end
   local i = 1
   local o = {}
   if le % 2 == 1 then
      table.insert(o, table.remove(b, 1))
      i = 2
   end
   for j = i, #s do
      if j % 2 == 1 then
         table.insert(o, table.remove(a))
      else
         table.insert(o, table.remove(b))
      end
   end
   return o      
end


if not is_wigglesorted({1,5,1,1,6,4}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if is_wigglesorted({1,6,1,5,1,4}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not is_wigglesorted({1,3,2,2,3,1}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if is_wigglesorted({2,3,1,3,1,2}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not is_wigglesorted({1,3,2,2,3,1}) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if is_wigglesorted(wigglesort({1,5,1,1,6,4})) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if is_wigglesorted(wigglesort({1,3,2,2,3,1})) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if is_wigglesorted(wigglesort({1,3,2,2,2,3,1})) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
