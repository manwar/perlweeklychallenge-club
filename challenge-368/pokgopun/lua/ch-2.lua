--# https://theweeklychallenge.org/blog/perl-weekly-challenge-368/
--[[

Task 2: Big and Little Omega

Submitted by: [63]Roger Bell_West
     __________________________________________________________________

   You are given a positive integer $number and a mode flag $mode. If the
   mode flag is zero, calculate little omega (the count of all distinct
   prime factors of that number). If it is one, calculate big omega (the
   count of all prime factors including duplicates).

Example 1

Input: $number = 100061
       $mode = 0
Output: 3

   Prime factors are 13, 43, 179. Count is 3.

Example 2

Input: $number = 971088
       $mode = 0
Output: 3

   Prime factors are 2, 2, 2, 2, 3, 20231. Count of distinct numbers is 3.

Example 3

Input: $number = 63640
       $mode = 1
Output: 6

   Prime factors are 2, 2, 2, 5, 37, 43. Count including duplicates is 6.

Example 4

Input: $number = 988841
       $mode = 1
Output: 2

Example 5

Input: $number = 211529
       $mode = 0
Output: 2
     __________________________________________________________________

   By submitting a response to the challenge you agree that your name or
   pseudonym, any photograph you supply and any other personal information
   contained in your submission may be published on this website and the
   associated mobile app. Last date to submit the solution 23:59 (UK Time)
]]
--# solution by pokgopun@gmail.com

--@param int
local function get_primes(n) --@return ints table
    local is_prime = {}
    for i = 1, n do is_prime[i] = (i > 1) end

    for i = 2, math.sqrt(n) do
        if is_prime[i] then
            for j = i * i, n, i do
                is_prime[j] = false
            end
        end
    end

    local results = {}
    for i = 1, n do
        if is_prime[i] then table.insert(results, i) end
    end
    --print(table.unpack(results))
    return results
end

--@param int, int
local function balo(number, mode) --@return int
	local n = number
	local m = {}
	local c = 0
	for _, p in ipairs(get_primes(number//2)) do
		--print(p)
		if n == 1 then
			break
		else
			while n % p == 0 do
				if mode == 0 then
					if not m[p] then
						c = c + 1
					end
				else
					c = c + 1
				end
				--print(p)
				m[p] = m[p] and m[p] + 1 or 1
				n = n // p
			end
		end
	end
	if n ~= 1 then
		c = c + 1
		m[number] = 1
	end
	--for k, v in pairs(m) do print(k,v) end
	--print(number, mode, c)
	return c
end

local lu = require("luaunit")

function TestBalo()
	local data = {
		100061 , 0 , 3 ,
		971088 , 0 , 3 ,
		63640 , 1 , 6 ,
		988841 , 1 , 2 ,
		211529 , 0 , 2,
	}
	for i=3, #data, 3 do
		local number, mode, otpt = data[i-2], data[i-1], data[i]
		lu.assertEquals(balo(number, mode), otpt)
	end
end

lu.run()
