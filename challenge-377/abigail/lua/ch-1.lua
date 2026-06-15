#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    for i = 1, #line - 1 do
        local c1 = line : sub (i, i)
        local c2 = line : sub (i + 1, i + 1)
        for j = 2, #line do
            local d1 = line : sub (j, j)
            local d2 = line : sub (j - 1, j - 1)
            if   c1 == d1 and c2 == d2
            then print ("true")
                 goto main_loop_end
            end
        end
    end
    print ("false")
    ::main_loop_end::
end
