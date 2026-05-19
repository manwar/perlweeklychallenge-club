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

function joins(t, pad)
   local out = ""
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

function rearrangespaces(a)
   local words = {}
   local spaces = 0
   local ww = ""
   for _, c in ipairs(split(a)) do
      if c == " " then
         spaces = spaces + 1
         if #ww > 0 then
            table.insert(words, ww)
            ww = ""
         end
      else
         ww = ww .. c
      end
   end
   if #ww > 0 then
      table.insert(words, ww)
   end
   local spdiv = 0
   local remainder = spaces
   local divs = #words - 1
   if divs > 0 then
      spdiv = spaces // divs
      remainder = spaces % divs
   end
   local out = joins(words, string.rep(" ", spdiv))
   if remainder > 0 then
      out = out .. string.rep(" ", remainder)
   end
   return out
end

if rearrangespaces("  challenge  ") == "challenge    " then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rearrangespaces("coding  is  fun") == "coding  is  fun" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rearrangespaces("a b c  d") == "a b c d " then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rearrangespaces("  team      pwc  ") == "team          pwc" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if rearrangespaces("   the  weekly  challenge  ") == "the    weekly    challenge " then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

