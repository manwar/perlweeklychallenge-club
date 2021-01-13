#!/usr/bin/env lua

local t2 = {}
local util = require'util'

function t2.reverse(coll)
  local result = {}
  for i=#coll,1,-1 do table.insert(result, coll[i]) end
  return result
end

function t2.transpose(matrix)
    local result = {}
    for i=1,#matrix[1] do
        result[i] = {}
        for j=1,#matrix do
            result[i][j] = matrix[j][i]
        end
    end
    return result
end

function t2.rotate(matrix)
  local rotated = t2.reverse(t2.transpose(matrix))
  return rotated
end

function t2.spiral(matrix)
  local spiral_aux
  spiral_aux = function(matrix, result)
    if next(matrix) then
      table.move(matrix[1], 1, #matrix[1], #result+1, result)
      if #matrix > 2 then
        table.remove(matrix, 1)
        return spiral_aux(t2.rotate(matrix), result)
      else
        local reversed = t2.reverse(matrix[2])
        table.move(reversed, 1, #reversed, #result+1, result)
        return result
      end
    else
      return result
    end
  end
  return spiral_aux(matrix, {})
end

function t2.run(args)
  local filename = args[1]
  local matrix = util.parse_matrix_file(filename)
  local spiraled = t2.spiral(matrix)
  util.print_matrix({spiraled}, ', ')
end

return t2
