local t2 = {}
t2.DEFAULT_INPUT = {'kitten', 'sitting'}

function t2.zeros_matrix(m, n)
  local matrix = {}
  for i = 1, m  do
    matrix[i] = {}
    for j = 1, n do
      matrix[i][j] = 0
    end
  end
  return matrix
  end

function t2.edit_distance(s1, s2)
  local m = #s1
  local n = #s2
  local dp = t2.zeros_matrix(m, n)

  for i = 1, m do
    for j = 1, n do
      if i == 1 then
        dp[i][j] = j
      elseif j == 1 then
        dp[i][j] = i
      elseif s1:sub(i, i) == s2:sub(j, j) then
        dp[i][j] = dp[i - 1][j - 1]
      else
        dp[i][j] = 1 + math.min(dp[i][j - 1],
                                dp[i - 1][j],
                                dp[i - 1][j - 1])
      end
    end
  end

  return dp[m][n]
end

function t2.run(args)
  local s1, s2
  if #args > 0 then
    s1, s2 = args[1], args[2]
  else
    s1, s2 = table.unpack(t2.DEFAULT_INPUT)
  end

  print(t2.edit_distance(s1, s2))
end

return t2
