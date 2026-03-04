--# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/
--[[

Task 2: Subnet Sheriff

Submitted by: [53]Peter Campbell Smith
     __________________________________________________________________

   You are given an IPv4 address and an IPv4 network (in CIDR format).

   Write a script to determine whether both are valid and the address
   falls within the network. For more information see the [54]Wikipedia
   article.

Example 1

Input: $ip_addr = "192.168.1.45"
       $domain  = "192.168.1.0/24"
Output: true

Example 2

Input: $ip_addr = "10.0.0.256"
       $domain  = "10.0.0.0/24"
Output: false

Example 3

Input: $ip_addr = "172.16.8.9"
       $domain  = "172.16.8.9/32"
Output: true

Example 4

Input: $ip_addr = "172.16.4.5"
       $domain  = "172.16.0.0/14"
Output: true

Example 5

Input: $ip_addr = "192.0.2.0"
       $domain  = "192.0.2.0/25"
Output: true
     __________________________________________________________________

   Last date to submit the solution 23:59 (UK Time) Sunday 8th March 2026.
     __________________________________________________________________

SO WHAT DO YOU THINK ?
--]]
--# solution by pokgopun@gmail.com
--@param ip4String string
local function ip4Octets(ip4String) --@return octets table or nil
	if type(ip4String) ~= "string" then
		return nil
	end
	local octets = {}
	for n in (ip4String.."."):gmatch("(.-)%.") do
		n = tonumber(n)
		if not n or n < 0 or n > 255 then
			return nil
		end
		table.insert(octets, n)
	end
	return octets
end

--@param ip_addr string, domain string
local function subnetSheriff(ip_addr, domain) --@return bool
	local ip = ip4Octets(ip_addr)
	if not ip then
		return false
	end
	local net_addr, mask = domain:match("(.-)/(.+)")
	mask = tonumber(mask)
	if not mask or mask < 0 or mask > 32 then
		return false
	end
	local net = ip4Octets(net_addr)
	if not net then
		return false
	end
	local n = mask // 8
	for i=1, n do
		if ip[i] ~= net[i] then
			return false
		end
	end
	local b = mask % 8
	if b == 0 then
		return true
	end
	n = n + 1
	if ip[n] == net[n] then
		return true
	end
	b = 8 - b
	return ip[n] >> b == ip[n] >> b
end

local lu = require("luaunit")

function TestSubnetSheriff()
	local data = {
		"192.168.1.45" ,"192.168.1.0/24" ,true ,
		"10.0.0.256" ,"10.0.0.0/24" ,false ,
		"172.16.8.9" ,"172.16.8.9/32" ,true ,
		"172.16.4.5" ,"172.16.0.0/14" ,true ,
		"192.0.2.0" ,"192.0.2.0/25" ,true,
	}
	for i=3, #data, 3 do
		local ip_addr, domain, otpt = data[i-2], data[i-1], data[i]
		lu.assertEquals(subnetSheriff(ip_addr, domain), otpt)
	end
end

lu.run()
