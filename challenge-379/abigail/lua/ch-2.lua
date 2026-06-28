#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local base  = 0
    local limit = 0
    for value in line : gmatch ("%d+")
    do  if   base == 0 
        then base  = tonumber (value)
        else limit = tonumber (value)
        end
    end
    for n = 0, limit
    do  local size = 0
        local n_c = n
        while n_c > 0
        do  size = size + 1
            n_c  = n_c // base
        end
        local sum = 0
        n_c = n
        while n_c > 0
        do  sum = sum + math . floor ((n_c % base) ^ size)
            n_c = n_c // base
        end
        if   sum == n 
        then io . write (sum)
             io . write (" ")
        end
    end
    io . write ("\n")
end
