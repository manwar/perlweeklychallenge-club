#!/usr/bin/env lua

--[[
    This is a Lua implementation of Peter Novig's excellent sudoku solver,
    originally written in Python:
      [Solving Every Sudoku Puzzle](http://norvig.com/sudoku.html)
--]]

local M = require('moses')

local t2 = {}


--[[ utility ]]--
function t2.contains(tbl, elem)
  for _, v in pairs(tbl) do
    if v == elem then return true end
  end
  return false
end

function t2.slurp(input)
  local fh = assert(io.open(input, "r"))
  local text = fh:read("*all")
  fh:close()
  return text
end

function t2.deep_copy(tbl)
  local copy = {}
  for k, v in pairs(tbl) do
    copy[k] = v
  end
  return copy
end

function t2.dict(tbl)
  local result = {}
  for _, v in pairs(tbl) do
    result[v[1]] = v[2]
  end
  return result
end

function t2.cross(a, b)
  local result = {}
  for _, aa in ipairs(a) do
    for _, bb in ipairs(b) do
      table.insert(result, aa .. bb)
    end
  end
  return result
end

function t2.build_unitlist(rows, cols)
  local result = {}
  for _, c in ipairs(cols) do table.insert(result, t2.cross(rows, {c})) end
  for _, r  in ipairs(rows) do table.insert(result, t2.cross({r}, cols)) end

  for rs in M.partition(rows, 3) do
    for cs in M.partition(cols, 3) do
      table.insert(result, t2.cross(rs, cs))
    end
  end

  return result
end

function t2.center(s, width)
  local space = width - #s + 1
  local n = math.floor(space/2)
  local lead = ((n > 1) and (' '):rep(n)) or ''
  return lead .. s .. (' '):rep(space - n)
end

--[[ unit tests ]]--
function t2.test()
    assert(#t2.squares == 81)
    assert(#t2.unitlist == 27)
    assert(M.all(M.map(t2.squares, function (v) return #t2.units[v] == 3 end), M.identity))
    assert(M.all(M.map(t2.squares, function (v) return #t2.peers[v] == 20 end), M.identity))

    assert(M.isEqual(t2.units['C2'], {
      {'A2', 'B2', 'C2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2'},
      {'C1', 'C2', 'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9'},
      {'A1', 'A2', 'A3', 'B1', 'B2', 'B3', 'C1', 'C2', 'C3'}}))

    local c2_peers = {'A2', 'B2', 'D2', 'E2', 'F2', 'G2', 'H2', 'I2', 'C1',
      'C3', 'C4', 'C5', 'C6', 'C7', 'C8', 'C9', 'A1', 'A3', 'B1', 'B3'}
    assert(M.isEqual(
      M.symmetricDifference(t2.peers['C2'], c2_peers),
      M.symmetricDifference(c2_peers, t2.peers['C2'])))
end

--[[ parse a grid ]]--
function t2.grid_values(grid)
  local chars = M.tabulate(grid:gsub(';.-[\r\n]',''):gmatch'[%d_.]')
  assert(#chars == 81)
  return t2.dict(M.zip(t2.squares, chars))
end

function t2.parse_grid(grid)
  local values = {}
  for _, s in pairs(t2.squares) do values[s] = table.concat(t2.digits) end

  for s, d in pairs(t2.grid_values(grid)) do
    if t2.contains(t2.digits, d) and not t2.assign(values, s, d) then
      return false
    end
  end
  return values
end

--[[ constraint propagation ]]--
function t2.assign(values, s, d)
  local other_values = values[s]:gsub(d, '')
  for d2 in other_values:gmatch'%d' do
    if not t2.eliminate(values, s, d2) then
      return false
    end
  end

  return values
end

function t2.eliminate(values, s, d)
  if not values[s]:match(d) then
    return values
  end
  values[s] = values[s]:gsub(d, '')

  -- (1) If a square s is reduced to one value d2, then eliminate d2 from the peers.
  if values[s]:len() == 0 then
    return false
  elseif values[s]:len() == 1 then
    local d2 = values[s]
    for _, s2 in ipairs(t2.peers[s]) do
      if not t2.eliminate(values, s2, d2) then
        return false
      end
    end
  end

  -- (2) If a unit u is reduced to only one place for a value d, then put it there.
  local dplaces
  for _, u in ipairs(t2.units[s]) do
    dplaces = {}
    for _, v in ipairs(u) do
      if values[v]:match(d) then table.insert(dplaces, v) end
    end
    if #dplaces == 0 then
      return false
    elseif #dplaces == 1 then
      -- d can only be in one place in unit; assign it there
      if not t2.assign(values, dplaces[1], d) then
        return false
      end
    end
  end

  return values
end

--[[ display as 2-D grid ]]--
function t2.display(values)
  local width = 1 + M.max(t2.squares, function (v) return #values[v] end)
  local line = table.concat(M.rep(string.rep('-', (width * 3)), 3), '+')

  local closer
  for _, r in ipairs(t2.rows) do
    for _, c in ipairs(t2.cols) do
      if ((c == '3') or (c == '6')) then closer = '|' else closer = '' end
      io.write(t2.center(values[r .. c], width) .. closer)
    end
    print()
    if ((r == 'C') or (r == 'F')) then print(line) end
  end
  print()
end

--[[ search ]]--
function t2.choose_unfilled(values)
  local min_len
  local min_val
  local cur_len
  for _, v in pairs(t2.squares) do
    cur_len = values[v]:len()
    if cur_len > 1 then
      if not min_len or ((cur_len <= min_len) and (v <= min_val)) then
        min_len = cur_len
        min_val = v
      end
    end
  end

  return min_val
end

function t2.search(values)
  if not values then
    return false --failed earlier
  end
  if M.all(t2.squares, function (v) return values[v]:len() == 1 end) then
    return values --solved
  end
  -- chose the unfilled square s with the fewest possibilities
  local s = t2.choose_unfilled(values)

  local result
  for d in values[s]:gmatch'%d' do
    result = t2.search(t2.assign(t2.deep_copy(values), s, d))
    if result then return result end
  end
end

function t2.solve(grid)
  return t2.search(t2.parse_grid(grid))
end

--[[ Setup ]]--
do
  t2.digits = M.map(M.range(9), tostring)
  t2.rows = M.tabulate(('ABCDEFGHI'):gmatch '.')
  t2.cols = t2.digits
  t2.squares = t2.cross(t2.rows, t2.cols)
  t2.unitlist = t2.build_unitlist(t2.rows, t2.cols)

  t2.units = {}
  t2.peers = {}
  for _, s in ipairs(t2.squares) do
    t2.units[s] = M.filter(t2.unitlist, function (v) return t2.contains(v, s) end)
    t2.peers[s] = M.symmetricDifference(M.union(table.unpack(t2.units[s])), {s})
  end
end

function t2.run(args)
  --t2.test()

  local filename = args[1]
  local grid = t2.slurp(filename)
  local values = t2.solve(grid)

  if values then
    t2.display(values)
  else
    print("Can't solve!")
  end
end

return t2
