#! /usr/bin/lua

-- by hookenz at
-- https://stackoverflow.com/questions/9168058/how-to-dump-a-table-to-console
function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

Reserve = {values = {}, counts = {}, vm = {}}

function Reserve:new(vv)
   local o = {}
   self.__index = self
   setmetatable(o,self)
   o.values = vv
   table.sort(o.values, function (aa, bb) return bb < aa end)
   o.counts = {}
   o.vm = {}
   for i, n in ipairs(o.values) do
      table.insert(o.counts, 0)
      o.vm[n] = i
   end
   return o
end

function Reserve:makechange(price, tendered)
   local val = 0
   for _, note in ipairs(tendered) do
      if self.vm[note] == nil then
         return false
      end
      self.counts[self.vm[note]] = self.counts[self.vm[note]] + 1
      val = val + note
   end
   if val < price then
      return false
   end
   val = val - price
   for bid = 1, #self.values do
      while val >= self.values[bid] and self.counts[bid] > 0 do
         val = val - self.values[bid]
         self.counts[bid] = self.counts[bid] - 1
      end
   end
   return (val == 0)
end

function exactchange(a)
   local reserve = Reserve:new({5, 10, 20})
   for _, tendered in ipairs(a) do
      if not reserve:makechange(5, {tendered}) then
         return false
      end
   end
   return true
end

if exactchange({5, 5, 5, 10, 20}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not exactchange({5, 5, 10, 10, 20}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if exactchange({5, 5, 5, 20}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

