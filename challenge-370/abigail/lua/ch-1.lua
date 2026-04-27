#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    --[[
      Parse input; everything before the // is the paragraph,
      every thing after the // are banned words
    ]]
    
    local i = 0
    for part in line : lower () : gmatch ("[^/]+") do
        if i == 0 then paragraph  = part end
        if i == 1 then banned_str = part end
        i = i + 1
    end

    --[[
      Extract the banned words, and put them in the banned table
    ]]
    local banned = {}
    for ban in banned_str : gmatch ("%a+") do
        banned [ban] = 1
    end
 
    --[[
      Extract the words from the paragraph (sequences of letters).
      If the word isn't banned, count it in the ok table.
    ]]

    local ok = {}
    for word in paragraph : gmatch ("%a+") do
        if   banned [word] == nil
        then if   ok [word] == nil
             then ok [word] = 0
             end
             ok [word] = ok [word] + 1
        end
     end

     --[[
       Find the word which occurs most frequently
     ]]
     local max = ""
     ok [max] = 0
     for word in pairs (ok) do
         if   ok [word] > ok [max]
         then max = word
         end
     end

     print (max)
end
