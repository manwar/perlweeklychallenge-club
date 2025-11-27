--# https://theweeklychallenge.org/blog/perl-weekly-challenge-349/
--[[

Task 2: Meeting Point

Submitted by: [48]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given instruction string made up of U (up), D (down), L (left)
   and R (right).

   Write a script to return true if following the instruction, you meet
   (0,0) at any point along the sequence.

Example 1

Input: $path = "ULD"
Output: false

(-1,1) <- (0,1)
   |        ^
   v        |
(-1,0)    (0,0)

Example 2

Input: $path = "ULDR"
Output: true

 (-1,1) <- (0,1)
    |        ^
    v        |
 (-1,0) -> (0,0)

Example 3

Input: $path = "UUURRRDDD"
Output: false

(0,3) -> (1,3) -> (2,3) -> (3,3)
  ^                          |
  |                          v
(0,2)                      (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0)                      (3,0)

Example 4

Input: $path = "UURRRDDLLL"
Output: true

(0,2) -> (1,2) -> (2,2) -> (3,2)
  ^                          |
  |                          v
(0,1)                      (3,1)
  ^                          |
  |                          v
(0,0) <- (1,0) <- (1,1) <- (3,0)

Example 5

Input: $path = "RRUULLDDRRUU"
Output: true

(0,2) <- (1,2) <- (2,2)
  |                 ^
  v                 |
(0,1)             (2,1)
  |                 ^
  v                 |
(0,0) -> (1,0) -> (2,1)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 30th November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@param path string
local function mp(path) --@return bool
	local x, y = 0, 0
	for v in string.gmatch(path, ".") do
		if v == "U" then
			y = y + 1
		elseif v == "D" then
			y = y - 1
		elseif v == "L" then
			x = x - 1
		elseif v == "R" then
			x = x + 1
		end
		if x == 0 and y == 0 then
			return true
		end
	end
	return false
end

local lu = require("luaunit")

function TestMp()
	for _, data in ipairs({
		{Input=  "ULD",Output= false},
		{Input=  "ULDR",Output= true},
		{Input=  "UUURRRDDD",Output= false},
		{Input=  "UURRRDDLLL",Output= true},
		{Input=  "RRUULLDDRRUU",Output= true}}) do
		lu.assertEquals(mp(data.Input), data.Output) 
	end
end

lu.run()

