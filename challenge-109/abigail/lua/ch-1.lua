#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua [plain | compute]
--

local PLAIN   =  0
local COMPUTE =  1

local COUNT   = 20

function divisor_sum (n)
    local sum = 0
    for i = 2, n - 2 do
        if   n % i == 0 
        then sum = sum + i
        end
    end
    return (sum)
end

local type = PLAIN
if   #arg >= 1 and arg [1] == "compute"
then type = COMPUTE
end

if   type == PLAIN
then print ("0, 0, 0, 2, 0, 5, 0, 6, 3, 7, 0, 15, 0, 9, 8, 14, 0, 20, 0, 21")
end

if   type == COMPUTE
then for n = 1, COUNT do
         if n > 1 
         then io . write (", ")
         end
         io . write (divisor_sum (n))
     end
     io . write ("\n")
end
