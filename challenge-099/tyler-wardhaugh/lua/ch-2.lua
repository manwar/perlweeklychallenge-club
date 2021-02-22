local t2 = {}
t2.DEFAULT_INPUT = {'littleit', 'lit'}

--[[
     Use a dynamic programming algorithm to solve unique subsequences.
     Source: https://www.geeksforgeeks.org/count-distinct-occurrences-as-a-subsequence/
--]]
function t2.unique_subsequences(s, t)
  local m = #t
  local n = #s

  if m > n then
    return 0
  end

  local dp = {}
  do
    local zeros, ones = {}, {}
    for _ = 1, n + 1 do
      table.insert(zeros, 0)
      table.insert(ones, 1)
    end
    for i = 1, m + 1 do
      if i == 1 then
        table.insert(dp, {table.unpack(ones)})
      else
        table.insert(dp, {table.unpack(zeros)})
      end
    end
  end

  for i = 2, m + 1 do
    for j = 2, n + 1 do
      if t:sub(i - 1, i - 1) ~= s:sub(j - 1, j - 1) then
        dp[i][j] = dp[i][j - 1]
      else
        dp[i][j] = dp[i][j - 1] + dp[i - 1][j - 1]
      end
    end
  end

  return dp[m + 1][n + 1]
end

function t2.run(args)
  local s, t
  if #args > 0 then
    s, t = args[1], args[2]
  else
    s, t = table.unpack(t2.DEFAULT_INPUT)
  end

  print(t2.unique_subsequences(s, t))
end

return t2
