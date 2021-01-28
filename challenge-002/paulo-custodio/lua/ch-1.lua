#!/usr/bin/env lua

--[[
Challenge 002

Challenge #1
Write a script or one-liner to remove leading zeros from positive numbers.
--]]

num = string.gsub(arg[1], "^0+(%d)", "%1")
io.write(num, "\n")
