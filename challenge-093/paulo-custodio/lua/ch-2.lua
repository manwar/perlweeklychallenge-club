#!/usr/bin/env lua

--[[
Challenge 093

TASK #2 > Sum Path
Submitted by: Mohammad S Anwar
You are given binary tree containing numbers 0-9 only.

Write a script to sum all possible paths from root to leaf.

Example 1:
Input:
     1
    /
   2
  / \
 3   4

Output: 13
as sum two paths (1->2->3) and (1->2->4)
Example 2:
Input:
     1
    / \
   2   3
  /   / \
 4   5   6

Output: 26
as sum three paths (1->2->4), (1->3->5) and (1->3->6)
--]]


-- read standard input into array
function read_input()
    local lines = {}
    while true do
        local line = io.read()
        if line == nil then break end
        lines[#lines + 1] = line
    end
    return lines
end

-- get a character from lines, blank if out of bounds
function ch(lines, row, col)
    if row<1 or row>#lines then return ' ' end
    if col<1 or col>#(lines[row]) then return ' ' end
    return string.sub(lines[row], col, col)
end

-- parse a subtree at row,col
function parse_subtree(lines, row, col)
    local tree = {}
    tree.value = tonumber(ch(lines,row,col))

    if ch(lines, row + 1, col - 1) == '/' then
        tree.left = parse_subtree(lines, row + 2, col - 2)
    end

    if ch(lines, row + 1, col + 1) == '\\' then
        tree.right = parse_subtree(lines, row + 2, col + 2)
    end

    return tree
end

-- parse a tree, return root Node
function parse_tree(lines)
    local col = string.find(lines[1], "%d")
    return parse_subtree(lines, 1, col)
end

-- return the subtree path len
function add_subtree_paths(node, cur_len, total_len)
    cur_len = cur_len + node.value
    if node.left then
        total_len = add_subtree_paths(node.left, cur_len, total_len)
    end
    if node.right then
        total_len = add_subtree_paths(node.right, cur_len, total_len)
    end
    if not node.left and not node.right then
        total_len = total_len + cur_len
    end

    return total_len
end

-- sum all sub-tree paths
function add_tree_paths(tree)
    return add_subtree_paths(tree, 0, 0)
end

io.write(add_tree_paths(parse_tree(read_input())), "\n")
