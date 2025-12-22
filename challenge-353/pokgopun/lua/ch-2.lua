--# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/
--[[

Task 2: Validate Coupon

Submitted by: [74]Mohammad Sajid Anwar
     __________________________________________________________________

   You are given three arrays, @codes, @names and @status.

   Write a script to validate codes in the given array.
A code is valid when the following conditions are true:
- codes[i] is non-empty and consists only of alphanumeric characters (a-z, A-Z,
0-9) and underscores (_).
- names[i] is one of the following four categories: "electronics", "grocery", "p
harmacy", "restaurant".
- status[i] is true.

   Return an array of booleans indicating validity: output[i] is true if
   and only if codes[i], names[i] and status[i] are all valid.

Example 1

Input: @codes  = ("A123", "B_456", "C789", "D@1", "E123")
       @names  = ("electronics", "restaurant", "electronics", "pharmacy", "groce
ry")
       @status = ("true", "false", "true", "true", "true")
Output: (true, false, true, false, true)

Example 2

Input: @codes  = ("Z_9", "AB_12", "G01", "X99", "test")
       @names  = ("pharmacy", "electronics", "grocery", "electronics", "unknown"
)
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, false)

Example 3

Input: @codes  = ("_123", "123", "", "Coupon_A", "Alpha")
       @names  = ("restaurant", "electronics", "electronics", "pharmacy", "groce
ry")
       @status = ("true", "true", "false", "true", "true")
Output: (true, true, false, true, true)

Example 4

Input: @codes  = ("ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4")
       @names  = ("electronics", "electronics", "grocery", "grocery")
       @status = ("true", "true", "true", "true")
Output: (true, true, true, true)

Example 5

Input: @codes  = ("CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99")
       @names  = ("restaurant", "electronics", "grocery", "pharmacy", "electroni
cs")
       @status = ("true", "true", "true", "true", "false")
Output: (true, true, true, true, false)
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 28th December
   2025.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com

--@param code string
local function isCode(code) --@return bool
	local c
	for i=1, #code do
		c = string.byte(code, i)
		if not (c == 95 or (c >= 48 and c <= 57) or (c >= 65 and c <= 90) or (c >= 97 and c <= 122)) then
			return false
		end
	end
	return true
end

--@param name string
local function isCat(name) --@return bool
	return name == "electronics" or name == "grocery" or name == "pharmacy" or name == "restaurant"
end

--@param codes table, names table, status table
local function validateCoupon(codes, names, status) --@return bools table
	local bools = {}
	for i=1, #codes do
		table.insert(bools, status[i] == "true" and isCat(names[i]) and isCode(codes[i]))
	end
	return bools
end

local lu = require("luaunit")

function TestValidateCoupon()
	for _, data in pairs({
		{
			codes  = {"A123", "B_456", "C789", "D@1", "E123"},
			names  = {"electronics", "restaurant", "electronics", "pharmacy", "grocery"},
			status = {"true", "false", "true", "true", "true"},
			Output= {true, false, true, false, true}
		},
		{
			codes  = {"Z_9", "AB_12", "G01", "X99", "test"},
			names  = {"pharmacy", "electronics", "grocery", "electronics", "unknown"},
			status = {"true", "true", "false", "true", "true"},
			Output= {true, true, false, true, false}
		},
		{
			codes  = {"_123", "123", "", "Coupon_A", "Alpha"},
			names  = {"restaurant", "electronics", "electronics", "pharmacy", "grocery"},
			status = {"true", "true", "false", "true", "true"},
			Output= {true, true, false, true, true}
		},
		{
			codes  = {"ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"},
			names  = {"electronics", "electronics", "grocery", "grocery"},
			status = {"true", "true", "true", "true"},
			Output= {true, true, true, true}
		},
		{
			codes  = {"CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"},
			names  = {"restaurant", "electronics", "grocery", "pharmacy", "electronics"},
			status = {"true", "true", "true", "true", "false"},
			Output= {true, true, true, true, false}
		}}) do
		lu.assertEquals(validateCoupon(data.codes,data.names,data.status), data.Output)
	end
end

lu.run()
