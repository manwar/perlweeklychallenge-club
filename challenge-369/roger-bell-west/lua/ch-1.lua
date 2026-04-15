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

function validtag(a)
   local p = "#"
   local up = false
   for _, c in ipairs(split(a)) do
      if string.match(c, "%a") then
         local cc = c
         if up then
            cc = string.upper(cc)
            up = false
         else
            cc = string.lower(cc)
         end
         p = p .. cc
      elseif c == " " and #p > 1 then
         up = true
      end
   end
   if #p > 100 then
      p = string.sub(p, 1, 100)
   end
   return p
end

if validtag("Cooking with 5 ingredients!") == "#cookingWithIngredients" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtag("the-last-of-the-mohicans") == "#thelastofthemohicans" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtag("  extra spaces here") == "#extraSpacesHere" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtag("iPhone 15 Pro Max Review") == "#iphoneProMaxReview" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if validtag("Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!") == "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

