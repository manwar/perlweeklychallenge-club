#!/usr/bin/env lua

local t1 = {}
t1.DEFAULT_INPUT = 1221

function t1.is_palindrome(n)
  local nstr = tostring(n)
  local mid = #nstr // 2

  local function _is_palindrome(s, e)
    if e < mid and s > mid then
      return true
    elseif nstr:sub(s, s) ~= nstr:sub(e, e) then
      return false
    else
      return _is_palindrome(s + 1, e - 1)
    end
  end

  return _is_palindrome(1, #nstr)
end


function t1.run(args)
  local n
  if #args > 0 then
    n = tonumber(args[1])
  else
    n = t1.DEFAULT_INPUT
  end

  if t1.is_palindrome(n) then
    print(1)
  else
    print(0)
  end
end

return t1
