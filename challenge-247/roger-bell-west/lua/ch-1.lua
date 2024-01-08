#! /usr/bin/lua

-- bart at https://stackoverflow.com/questions/1426954/split-string-in-lua
function split(inputstr, sep)
   sep=sep or '%s'
   local t={}
   for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
      table.insert(t,field)
      if s=="" then
         return t
      end
   end
end

function secretsanta(name)
   local family = {}
   for _, n in ipairs(name) do
      local surname = split(n, " ")
      table.insert(family, surname[#surname])
   end
   local receivers = {}
   for n = 1, #name do
      receivers[n] = true
   end
   local gifting = {}
   for giver = 1, #name do
      local done = false
      local r = 0
      for recipient, _ in pairs(receivers) do
         if family[giver] ~= family[recipient] then
            r = recipient
            done = true
            break
         end
      end
      if not done then
         for recipient, _ in pairs(receivers) do
            if giver ~= recipient then
               r = recipient
               break
            end
         end
      end
      receivers[r] = nil
      table.insert(gifting, {name[giver], name[r]})
   end
   for _, p in ipairs(gifting) do
      io.write(p[1])
      io.write(" -> ")
      print(p[2])
   end
   print("")
   return true
end

if secretsanta({"Mr. Wall", "Mrs. Wall", "Mr. Anwar", "Mrs. Anwar", "Mr. Conway", "Mr. Cross"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if secretsanta({"Mr. Wall", "Mrs. Wall", "Mr. Anwar"}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

