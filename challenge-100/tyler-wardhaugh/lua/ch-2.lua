local t2 = {}
t2.DEFAULT_INPUT = { {1}, {2,4}, {6,4,9}, {5,1,7,2} }

function t2.min_triangle_sum(triangle)
  local n = #triangle

  local left, right
  for i = n - 1, 1, -1 do
    for j = 1, i do
      left = triangle[i + 1][j]
      right = triangle[i + 1][j + 1]
      triangle[i][j] = triangle[i][j] + math.min(left, right)
    end
  end

  return triangle[1][1]
end

function t2.run(_)
  local triangle = t2.DEFAULT_INPUT
  print(t2.min_triangle_sum(triangle))
end

return t2
