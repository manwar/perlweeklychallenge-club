#! /usr/bin/lua

function matrixscore(matrix0)
   local matrix = matrix0
   for i = 1, #matrix do
      if matrix[i][1] == 0 then
         for j = 1, #(matrix[i]) do
            matrix[i][j] = 1 - matrix[i][j]
         end
      end
   end
   local t = #matrix // 2
   for i = 2, #(matrix[1]) do
      local c = 0
      for j = 1, #matrix do
         if matrix[j][i] == 0 then
            c = c + 1
         end
      end
      if c > t then
         for j = 1, #matrix do
            matrix[j][i] = 1 - matrix[j][i]
         end
      end
   end
   local tot = 0
   for _a, m in ipairs(matrix) do
      local p = 0
      for _b, n in ipairs(m) do
         p = p * 2
         if n == 1 then
            p = p + 1
         end
      end
      tot = tot + p
   end
   return tot
end

if matrixscore({{0, 0, 1, 1}, {1, 0, 1, 0}, {1, 1, 1, 0}}) == 39 then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if matrixscore({{0}}) == 1 then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

