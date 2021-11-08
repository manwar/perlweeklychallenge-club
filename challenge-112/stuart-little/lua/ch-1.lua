#!/usr/bin/env lua

-- run <script> <path>

function deSlash(s)
   local news = s:gsub("/+","/"):gsub("(.+)/$","%1")
   return news
end

function deDot(s)
   local news = s:gsub("/%./","/"):gsub("/%.$","")
   return news
end

function deDblDotMid(s)
   local news=s:gsub("/%.%.$","/../")
   local fst = news:gmatch("([^/]*)/%.%./")()
   if not fst then return news end
   if fst == ".." or fst=="" then error("Too many double dots!") end
   local sml = news:gsub(fst.."/%.%./","/",1)
   return deDblDotMid(deSlash(sml))
end

function norm(s)
   return deSlash(deDblDotMid(deDot(s)))
end

print(norm(arg[1]))
