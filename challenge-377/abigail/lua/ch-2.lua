#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    local words = {}
    for word in line : gmatch ("%S+") do
        table . insert (words, word)
    end

    local count = 0
    for i = 1, #words - 1 do
        for j = i + 1, #words do
            local w1 = words [i]
            local w2 = words [j]
            if  #w1 < #w2
            then
                w1 = words [j]
                w2 = words [i]
            end
            if   w1 : sub (1, #w2) == w2 and w1 : sub (-#w2) == w2
            then count = count + 1
            end
        end
    end

    print (count)
 
 
end
