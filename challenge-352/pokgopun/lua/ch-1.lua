--# https://theweeklychallenge.org/blog/perl-weekly-challenge-352/
--[[

Task 1: Match String

Submitted by: [67]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given an array of strings.

   Write a script to return all strings that are a substring of another
   word in the given array in the order they occur.

Example 1

Input: @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"
)
Output: ("cat", "dog", "dogcat", "rat")

Example 2

Input: @words = ("hello", "hell", "world", "wor", "ellow", "elloworld")
Output: ("hell", "world", "wor", "ellow")

Example 3

Input: @words = ("a", "aa", "aaa", "aaaa")
Output: ("a", "aa", "aaa")

Example 4

Input: @words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght")
Output: ("flow", "fl", "fli", "ig", "ght")

Example 5

Input: @words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent")
Output: ("car", "pet", "enter", "pen", "pent")

Task 2: Binary Prefix
--]]
--# solution by pokgopun@gmail.com

--@param words table
local function ms(words) --@return matches table
	local m = {}
	local idx = 0
	for i=1, #words do
		local sub = words[i]
		for j=1, #words do
			local sup = words[j]
			if i ~= j and string.find(sup,sub) and not m[sub] then
				idx = idx + 1
				m[sub] = idx
				m[idx] = sub
				break
			end
		end
	end
	for k, _ in pairs(m) do
		if type(k) == "string" then
			m[k] = nil
		end
	end
	return m
end

local lu = require("luaunit")

function TestMs()
	for _, data in pairs({
		{ Input = {"cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat"}, Output= {"cat", "dog", "dogcat", "rat"}},
		{Input = {"hello", "hell", "world", "wor", "ellow", "elloworld"}, Output= {"hell", "world", "wor", "ellow"}},
		{Input = {"a", "aa", "aaa", "aaaa"}, Output= {"a", "aa", "aaa"}},
		{Input = {"flower", "flow", "flight", "fl", "fli", "ig", "ght"},Output= {"flow", "fl", "fli", "ig", "ght"}},
		{Input = {"car", "carpet", "carpenter", "pet", "enter", "pen", "pent"},Output= {"car", "pet", "enter", "pen", "pent"}}}) do
		lu.assertEquals(ms(data.Input), data.Output)
	end
end

lu.run()
