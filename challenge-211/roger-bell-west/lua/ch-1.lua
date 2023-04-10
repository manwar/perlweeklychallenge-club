#! /usr/bin/lua

function toeplitzmatrix(a)
   local ym = #a - 1
   local xm = #(a[1]) - 1
   local toeplitz = true
   for xb = (1 - xm), (ym - 1) do
      local init = true
      local tv = 0
      for xi = xb, xb + xm do
         if xi >= 0 and xi <= xm then
            local x = xi + 1
            local yi = xi - xb
            if yi >= 0 and yi <= ym then
               local y = yi + 1
               if init then
                  init = false
                  tv = a[y][x]
               elseif a[y][x] ~= tv then
                  toeplitz = false
                  break
               end
            end
         end
      end
      if not toeplitz then
         break
      end
   end
   return toeplitz
end

if toeplitzmatrix({{4, 3, 2, 1}, {5, 4, 3, 2}, {6, 5, 4, 3}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if not toeplitzmatrix({{1, 2, 3}, {3, 2, 1}}) then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

