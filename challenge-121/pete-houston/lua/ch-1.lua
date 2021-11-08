#!/usr/bin/env lua
--[[
#===============================================================================
#
#         FILE: 12101.lua
#
#        USAGE: ./12101.lua M N 
#
#  DESCRIPTION: Invert the Nth least significant bit of number M and output.
#
#        NOTES: No input validation - GIGO.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 12/07/21
#===============================================================================
]]

print (arg[1] ~ 2 ^ (arg[2] - 1));
