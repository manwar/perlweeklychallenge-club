#! /usr/bin/lua

function maximumaverage(a, n)
    local t = 0
    for i = 1, n do
        t = t + a[i]
    end
    local mx = t
    for i = n + 1, #a do
        t = t + a[i]
        t = t - a[i - n]
        mx = math.max(mx, t)
    end
    return mx / n
end

if maximumaverage({1, 12, -5, -6, 50, 3}, 4) == 12.75 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if maximumaverage({5}, 1) == 5 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

