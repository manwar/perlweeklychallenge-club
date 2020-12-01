#!/usr/bin/env lua

local util = {}

function util.parse_matrix_file(filename)
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

function util.print_matrix(matrix, sep)
  sep = sep or ' '
  for _, row in ipairs(matrix) do
    io.write('[ ')
    io.write(table.concat(row, sep))
    io.write(' ]')
    print()
  end
end

return util
