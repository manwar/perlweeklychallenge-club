#!/usr/bin/env lua
--[[
#===============================================================================
#
#         FILE: 11602.lua
#
#        USAGE: ./11602.lua N
#
#  DESCRIPTION: Is the sum of the squares of the digits a square? 1 for
#               yes, 0 for no.
#
#        NOTES: N must be a decimal integer greater than 9
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 09/06/21
#===============================================================================
]]

function rssd (n) 
	-- root sum square digits
	local t = 0
	for c in string.gmatch (n, "%d") do
		t = t+c*c
	end
	return math.sqrt (t)
end

root = rssd (arg[1])
if (root == math.tointeger (root)) then 
	print (1)
else
	print (0)
end
