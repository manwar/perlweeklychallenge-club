#! /usr/bin/lua

function findwinner(a)
   local board = { { 0, 0, 0 }, { 0, 0, 0 }, { 0, 0, 0 } }
   local player = 1
   for _, play in ipairs(a) do
      board[1 + play[1]][1 + play[2]] = player
      player = 3 - player
   end
   for _, pattern in ipairs({
      {0, 0, 1, 0},
      {0, 1, 1, 0},
      {0, 2, 1, 0},
      {0, 0, 0, 1},
      {1, 0, 0, 1},
      {2, 0, 0, 1},
      {0, 0, 1, 1},
      {0, 2, 1, -1}
   }) do
      local cellvals = {}
      for i = 0, 2 do
         local x = 1 + pattern[1] + i * pattern[3]
         local y = 1 + pattern[2] + i * pattern[4]
         cellvals[board[y][x]] = true
      end
      local w = keys(cellvals)
      if #w == 1 then
         local winner = w[1]
         if winner == 1 then
            return "A"
         elseif winner == 2 then
            return "B"
         end
      end
   end
   if #a == 9 then
      return "Draw"
   else
      return "Pending"
   end
end

function keys(t)
   local a = {}
   for k, v in pairs(t) do
      table.insert(a, k)
   end
   return a
end

if findwinner({{0, 0}, {2, 0}, {1, 1}, {2, 1}, {2, 2}}) == "A" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if findwinner({{0, 0}, {1, 1}, {0, 1}, {0, 2}, {1, 0}, {2, 0}}) == "B" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if findwinner({{0, 0}, {1, 1}, {2, 0}, {1, 0}, {1, 2}, {2, 1}, {0, 1}, {0, 2}, {2, 2}}) == "Draw" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if findwinner({{0, 0}, {1, 1}}) == "Pending" then
  io.write("Pass")
else
  io.write("FAIL")
end
io.write(" ")

if findwinner({{1, 1}, {0, 0}, {2, 2}, {0, 1}, {1, 0}, {0, 2}}) == "B" then
  io.write("Pass")
else
  io.write("FAIL")
end
print("")

