#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local todo = {line}
    local i    = 1
    while i <= #todo do
        if   todo [i] : find ("%?")
        then todo [#todo + 1] = todo [i] : gsub ("%?", "0", 1)
             todo [#todo + 1] = todo [i] : gsub ("%?", "1", 1)
        else io . write (todo [i] .. " ")
        end
        i = i + 1
    end
    io . write ("\n")
end
