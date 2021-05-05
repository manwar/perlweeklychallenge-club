#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local longest = ""

for line in io . lines () do
    --
    -- Find words with their letters in lexical order, and which are
    -- longer than the longest found so far.
    --
    if   line : lower ()
              : find  ("^a*b*c*d*e*f*g*i*j*k*l*m*n*o*p*q*r*s*t*u*v*w*x*y*z*$")
         and line : len () > longest : len ()
    then longest = line
    end
end

print (longest)
