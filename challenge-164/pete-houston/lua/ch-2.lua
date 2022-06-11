#!/usr/bin/env lua
--[[
#===============================================================================
#
#         FILE: 16402.lua
#
#        USAGE: ./16402.lua N
#
#  DESCRIPTION: First N decimal Happy numbers
#
#        NOTES: N must be a natural number
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 13/05/22
#===============================================================================
]]

function is_happy (x) 
	local seen = {}
	seen[x] = 1
	while x ~= 1 do
		sum = 0
		for c in string.gmatch (x, "%d") do
			sum = sum + c * c
		end
		if seen[sum] then return 0 end
		seen[sum] = 1
		x = sum
	end
	return 1
end

m = tonumber (arg[1])
i = 1
while m > 0 do
	if is_happy (i) == 1 then
		print (i)
		m = m - 1
	end
	i = i + 1
end
