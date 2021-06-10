#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua
--

local COUNT   = 10
local PLAIN   =  0
local COMPUTE =  1

local type = PLAIN
if   #arg >= 1 and arg [1] == "compute"
then type = COMPUTE
end

if   type == PLAIN
then print ("1, 1, 2, 5, 15, 52, 203, 877, 4140, 21147")
end

if   type == COMPUTE
then local bell = {}
     bell [0] = {}
     bell [0] [0] = 1
     for x = 1, COUNT - 2
     do  bell [x] = {}
         bell [x] [0] = bell [x - 1] [x - 1]
         for  y = 1, x
         do   bell [x] [y] = bell [x] [y - 1] + bell [x - 1] [y - 1]
         end
     end

     io . write (1)
     for x = 0, COUNT - 2
     do  io . write (", " .. bell [x] [x])
     end
     io . write ("\n")
end
