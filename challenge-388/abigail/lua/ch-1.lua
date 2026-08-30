#!/opt/homebrew/bin/lua
 
function process (n, u, d, prefix)
    if d == n then io . write (prefix .. " ") end
    if d <  u then process (n, u, d + 1, prefix .. "D") end
    if u <  n then process (n, u + 1, d, prefix .. "U") end
end

 
for n in io . lines () do
    process (tonumber (n), 0, 0, "")
    print ("")
end
