#!/opt/homebrew/bin/lua
 
 
for line in io . lines () do
    --[[
      Parse the line of input. Split it into 'number' and 'mode';
      and make them integers.
    ]]
    local parts = {}
    for str in line : gmatch ("([^ ]+)") do
        table . insert (parts, str)
    end
    local number = parts [1] + 0
    local mode   = parts [2] + 0

    local diff_factors = 0
    local      factors = 0

    --[[
      Try dividing by 2, and all odd numbers larger than 2
      Count different and total factors.
     
      Note that this way, we will never divide by a composite number --
      if we encounter a composite number, we have already tried its factors.
    ]]
    n = 2
    while n * n <= number  -- No C-style for loop in lua
    do  if   number % n == 0
        then diff_factors = diff_factors + 1
             while number % n == 0
             do    factors = factors + 1
                   number  = number //  n
             end
        end
        if   n == 2
        then n = 3
        else n = n + 2
        end
    end

    --[[
      At this point, number is either 1 or a large prime, not encountered
      before. In the later case, add one of the number of factors and unique
      factors.
    ]]
    if   number ~= 1
    then diff_factors = diff_factors + 1
         factors = factors + 1
    end

    if   mode == 1
    then print (factors)
    else print (diff_factors)
    end
end
