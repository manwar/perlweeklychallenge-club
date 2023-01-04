#!/usr/bin/env lua

local function is_prime(n)
  assert(type(n) == 'number', 'n must be a number!')
  local i = 5
  if n == 2 or n == 3 then return true end
  if n <= 1 or n % 2 == 0 or n % 3 == 0 then return false end
  while i * i <= n do
    if n % i == 0 or n % (i+2) == 0 then return false end
    i = i + 6
  end
  return true
end

local function prime_count(n)
  assert(type(n) == 'number', 'n must be a number!')
  local count = 0
  for i=1,n-1 do
    if is_prime(i) then count = count + 1 end
  end
  return count
end

print(prime_count(10))
print(prime_count(15))
print(prime_count(1))
print(prime_count(25))

