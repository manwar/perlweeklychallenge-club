#!/usr/bin/env lua

local t2 = {}

function t2.parse_matrix_file(filename)
  local file = io.open(filename)
  io.input(file)

  local matrix = {}
  for line in io.lines() do
    local row = {}
    for d in string.gmatch(line, '%d+') do
      table.insert(row, math.tointeger(d))
    end
    table.insert(matrix, row)
  end

  return matrix
end

function t2.print_matrix(matrix)
  for _, row in ipairs(matrix) do
    io.write('[ ')
    for _, field in ipairs(row) do
      io.write(field, ' ')
    end
    io.write(']')
    print()
  end
end

function t2.count_squares(matrix)
  local count = 0

  local m = #matrix
  local n = #matrix[1]

  for i = 1,m do
    for j = 1,n do
      if matrix[i][j] ~= 1 then goto next end

      local min = math.min(m - i, n - j)

      for delta = 1,min do
        if matrix[i + delta][j] == 1 and matrix[i][j + delta] == 1
          and matrix[i + delta][j + delta] == 1 then
          count = count + 1
        end
      end

      ::next::
    end
  end

  return count
end

function t2.run(args)
  local matrix = t2.parse_matrix_file(args[1])
  print('Input:')
  t2.print_matrix(matrix)
  print()
  local count = t2.count_squares(matrix)
  print('Output:', count)
end

return t2
