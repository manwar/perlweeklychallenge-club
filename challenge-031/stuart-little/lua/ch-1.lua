#!/usr/bin/env lua

-- run <script> <numerator> <denominator>

local frac=arg[1]/arg[2]
print((frac ~=frac or frac==math.huge or frac==-math.huge) and "divided by zero" or frac)
