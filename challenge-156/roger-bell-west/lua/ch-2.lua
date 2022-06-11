#! /usr/bin/lua

function divisors(n)
   local ff={1}
   if n==1 then
      return ff
   end
   local s=math.floor(math.sqrt(n))
   if s * s == n then
      table.insert(ff,s)
      s = s - 1
   end
   for pf = 2,s do
      if n % pf == 0 then
         table.insert(ff,pf)
         table.insert(ff,math.floor(n/pf))
      end
   end
   return ff
end

function is_weird(n)
   local dd=divisors(n)
   local ts=0
   for i,v in ipairs(dd) do
      ts = ts + v
   end
   if ts <= n then
      return false
   end
   for mask = 1,(1 << #dd)-1 do
      local ss=0
      for i,d in ipairs(dd) do
         if mask & (1 << (i-1)) then
            ss = ss + d
            if ss > n then
               break
            end
         end
         if ss == n then
            return false
         end
      end
   end
   return true
end

if not is_weird(12) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if not is_weird(13) then
   io.write("Pass")
else
   io.write("FAIL")
end
io.write(" ")

if is_weird(70) then
   io.write("Pass")
else
   io.write("FAIL")
end
print("")
