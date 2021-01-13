#!/usr/bin/env lua

local t2 = {}

--[[
        1
       / \
      2   3
     / \
    4   5
       / \
      6   7
--]]
t2.DEFAULT_INPUT = {1, {2, {4}, {5, {6}, {7}}}, {3}}

function t2.tree_to_linked_list(tree)
  local function _tree_to_linked_list(tree, results)
    local val = tree[1]
    local left = tree[2]
    local right = tree[3]

    if val then
      table.insert(results, val)
    end

    if left then
      _tree_to_linked_list(left, results)
    end

    if right then
      _tree_to_linked_list(right, results)
    end

    return results
  end
  return _tree_to_linked_list(tree, {})
end

function t2.run(args)
  local tree
  if #args > 0 then
    tree = args
  else
    tree = t2.DEFAULT_INPUT
  end

  local result = t2.tree_to_linked_list(tree)
  print(table.concat(result, ' -> '))
end

return t2
