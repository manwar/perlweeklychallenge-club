#!/usr/bin/env lua

local function conflict_intervals(t)
  assert(type(t) == 'table','t must be a table!')
  for i=2,#t do
    local b = false
    for j=1,i-1 do
      if t[i][1] >= t[j][1] and t[i][1] <= t[j][2] then b = true end
    end
    if b then io.write(string.format('(%d %d) ',t[i][1],t[i][2])) end
  end
  print("")
end

conflict_intervals{{1,4},{3,5},{6,8},{12,13},{3,20}}
conflict_intervals{{3,4},{5,7},{6,9},{10,12},{13,15}}

