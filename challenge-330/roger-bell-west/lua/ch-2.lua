#! /usr/bin/lua

function split(t)
   local cl = {}
   string.gsub(t,
               "(.)",
               function(c)
                  table.insert(cl, c)
               end
   )
   return cl
end

function splits(inputstr, sep)
   sep=sep or '%s'
   local t={}
   for field,s in string.gmatch(inputstr, "([^"..sep.."]*)("..sep.."?)") do
      table.insert(t,field)
      if s=="" then
         return t
      end
   end
end

function join(t)
   local out=""
   for i, v in ipairs(t) do
      out = out .. v
   end
   return out
end

function joins(t,pad)
   local out=""
   local later = false
   for k,v in pairs(t) do
      if later then
         out = out .. pad
      end
      out = out .. v
      later = true
   end
   return out
end

function titlecapital(a)
   local out = {}
   for _, w in ipairs(splits(a, " ")) do
      local p = string.lower(w)
      if #p > 2 then
         local c = split(p)
         c[1] = string.upper(c[1])
         p = join(c)
      end
      table.insert(out, p)
   end
   return joins(out, " ")
end

if titlecapital("PERL IS gREAT") == "Perl is Great" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if titlecapital("THE weekly challenge") == "The Weekly Challenge" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if titlecapital("YoU ARE A stAR") == "You Are a Star" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

