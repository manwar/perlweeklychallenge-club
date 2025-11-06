--# https://theweeklychallenge.org/blog/perl-weekly-challenge-346/
--[[

Task 2: Magic Expression

Submitted by: [45]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given a string containing only digits and a target integer.

   Write a script to insert binary operators +, - and * between the digits
   in the given string that evaluates to target integer.

Example 1

Input: $str = "123", $target = 6
Output: ("1*2*3", "1+2+3")

Example 2

Input: $str = "105", $target = 5
Output: ("1*0+5", "10-5")

Example 3

Input: $str = "232", $target = 8
Output: ("2*3+2", "2+3*2")

Example 4

Input: $str = "1234", $target = 10
Output: ("1*2*3+4", "1+2+3+4")

Example 5

Input: $str = "1001", $target = 2
Output: ("1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1")
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 9th November
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

local function segCmb(n, l, tmp) 
	tmp = tmp or {}
	if n == 1 then
		table.insert(tmp,l)
		coroutine.yield(tmp)
	else
		for s=1, l-1 do
			local tmpc = table.move(tmp,1,#tmp,1,{})
			table.insert(tmpc, s)
			segCmb(n-1, l -s, tmpc)
		end
	end
end

local function evlCmb(n, dgtStr)
	local iter = coroutine.wrap(function () segCmb(n, #dgtStr) end)
	while true do
		local seg = iter()
		if not seg then
			break
		end
		--print(table.concat(seg," "))
		local res = {}
		local b = 1
		local i = 1
		while i <= n do
			local w = seg[i]
			local s = dgtStr:sub(b,b+w-1)
			if #s > 1 and s:sub(1,1) == "0" then
				break
			end
			table.insert(res, s)
			if i < n then
				table.insert(res, "")
			end
			b = b + w
			i = i + 1
		end
		if i > n then
			--print(table.concat(res," "))
			coroutine.yield(res)
		end
	end
end

local function bPowerN(b, n)
	local v = 1
	while n > 1 do
		v = v * b
		n = n - 1
	end
	return v
end

local function me(dgtStr, target)
	local res = {}
	local l = #dgtStr
	if l < 2 then
		return res
	end
	local ops = {"+", "-", "*"}
	local b = #ops
	for n=2, l do
		local iter  = coroutine.wrap(function () evlCmb(n, dgtStr) end)
		while true do
			local evl = iter()
			if not evl then
				break
			end
			--print("->",table.concat(evl," "))
			--print("power=",bPowerN(b, n)-1)
			for d = 0, bPowerN(b, n)-1 do
				--print("d=",d)
				local i = 2*n
				while d > 0 do
					i = i - 2
					--print("i=",i,ops[d%b+1])
					evl[i] = ops[d%b+1]
					d  = d // b
				end
				while i > 2 do
					i = i - 2
					--print("i=",i,ops[1])
					evl[i] = ops[1]
				end
				local evlStr = table.concat(evl,"")
				--print("=>",evlStr)
				if load("return "..evlStr)() == target then
					table.insert(res, evlStr)
				end
			end
		end
	end
	table.sort(res)
	--print(table.concat(res," "))
	return res
end

local lu = require("luaunit")

function TestMe()
	for _, data in pairs({
		{Input= {str = "123", target = 6},Output= {"1*2*3", "1+2+3"}},
		{Input= {str = "105", target = 5},Output= {"1*0+5", "10-5"}},
		{Input= {str = "232", target = 8},Output= {"2*3+2", "2+3*2"}},
		{Input= {str = "1234", target = 10},Output= {"1*2*3+4", "1+2+3+4"}},
		{Input= {str = "1001", target = 2},Output= {"1+0*0+1", "1+0+0+1", "1+0-0+1", "1-0*0+1", "1-0+0+1", "1-0-0+1"}}}) do
		--{Input= {str = "1234567890", target = 1979}, Output= {'1+2*3+45*6*7-8+90','1+2-3+45*6*7+89+0','1+2-3+45*6*7+89-0'}},
		--{Input= {str = "12304560789", target = 8532}, Output= {'1*2*30+4*5*60*7+8*9'}}}) do
		lu.assertEquals(me(data.Input.str,data.Input.target),data.Output)
	end
end

lu.run()
