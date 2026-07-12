#!/opt/homebrew/bin/lua
 
matrix = {}
 
for line in io . lines () do
    matrix [#matrix + 1] = {}
    for num in line : gmatch ("-?[0-9]*")
    do  table . insert (matrix [#matrix], tonumber (num))
    end
end

r = true

for i = 1, #matrix do
    row = {}
    col = {}
    for j = 1, #matrix do
        r = r and 1 <= matrix [i] [j] and matrix [i] [j] <= #matrix
        row [matrix [i] [j]] = 1
        col [matrix [j] [i]] = 1
    end
    r = r and #row == #matrix and #col == #matrix
end

print (r and "true" or "false")
