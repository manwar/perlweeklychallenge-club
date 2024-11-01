#!/usr/bin/env lua

local function boomerang(t)
  assert(type(t) == 'table','t must be a table!')
  return (t[2][2] - t[1][2]) * (t[3][1] - t[2][1]) ~=
    (t[3][2] - t[2][2]) * (t[2][1] - t[1][1])
end

print(boomerang{{1,1},{2,3},{3,2}})
print(boomerang{{1,1},{2,2},{3,3}})
print(boomerang{{1,1},{1,2},{2,3}})
print(boomerang{{1,1},{1,2},{1,3}})
print(boomerang{{1,1},{2,1},{3,1}})
print(boomerang{{0,0},{2,3},{4,5}})

