#! /usr/bin/lua

function maxgap(l0)
  if #l0 < 2 then
    return 0
  end
  l = l0
  table.sort(l0)
  q = {}
  for i = 1, #l-1 do
     table.insert(q, l[i + 1] - l[i])
  end
  mq = math.max(table.unpack(q))
  r = 0
  for i, v in ipairs(q) do
     if v == mq then
        r = r + 1
     end
  end
  return r
end

if maxgap({2, 5, 8, 1}) == 2 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")
if maxgap({3}) == 0 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")
