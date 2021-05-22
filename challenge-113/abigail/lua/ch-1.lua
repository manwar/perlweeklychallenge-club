#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

--     
-- For a description of the algorithm, and the proof why this is correct:
-- https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html
--  

local gcds = {1, 2, 1, 2, 5, 2, 1, 2, 1}

for  line in io . lines () do
     local _, _, N, D = line : find ("([0-9]+)%s+([0-9])")
     N = tonumber (N)
     D = tonumber (D)
     if   D == 0
     then if   N >= 100 or N % 10 == 0
          then print (1)
          else print (0)
          end
          goto end_loop
     end

     if   N >= D * 10
     then print (1)
          goto end_loop
     end
 
     for  i = 0, D / gcds [D] - 1
     do   local T = N - 10 * i - D
          if   T >= 0 and T % D == 0
          then print (1)
               goto end_loop
          end
     end

     print (0)
  
     ::end_loop::
end
