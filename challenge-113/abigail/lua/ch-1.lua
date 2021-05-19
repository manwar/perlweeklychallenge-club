#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

local tens = {0, 1, 2, 1, 0, 2, 6, 3, 8}

for  line in io . lines () do
     local _, _, N, D = line : find ("([0-9]+)%s+([0-9])")
     N = tonumber (N)
     D = tonumber (D)
     local D10 = 10 * D
     if   D == 0
     then D10 = 100
     end
     if   (N >= D10) or (D == 0 and N % 10 == 0)
                     or (D >  0 and N % D  == 0)
     then print (1)
          goto end_loop
     end
 
     if   D > 0
     then for  i = 1, tens [D]
          do   local T = N - 10 * i - D
               if  T >= 0 and T % D == 0
               then print (1)
                    goto end_loop
               end
          end
     end

     print (0)
  
     ::end_loop::
end
