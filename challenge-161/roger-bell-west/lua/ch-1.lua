#! /usr/bin/lua

b = {}
while true do
   local line = io.read()
   if line == nil then break end
   u = true
   for j = 1, #line-1 do
      if string.sub(line,j,j) > string.sub(line,j+1,j+1) then
         u = false
         break
      end
   end
   if u then
      table.insert(b,line)
   end
end

table.sort(b,function (aa,bb) return #bb < #aa end)
for i,v in ipairs(b) do
   print(v)
end
