#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-1.lua < input-file
--

for line in io . lines () do
    local graph = {}
    local nodes = {}
    for s in line : gmatch ("%S+")
    do  local first = s : sub ( 1,  1)
        local last  = s : sub (-1, -1)
        if   graph [first] == nil
        then graph [first] =  {}
        end
        graph [first] [last] = 1
        nodes [first] = 1
        nodes [last]  = 1
    end

    --
    -- Make sure all entries exists, as lua doesn't autovivify
    --
    for node1 in pairs (nodes)
    do  for node2 in pairs (nodes)
        do  if   graph [node1] == nil
            then graph [node1] = {}
            end
            if   graph [node1] [node2] == nil
            then graph [node1] [node2] = 0
            end
        end
    end

    --
    -- Calculate the transitive closure
    --
    for k in pairs (nodes)
    do  for i in pairs (nodes)
        do  for j in pairs (nodes)
            do  if   graph [i] [j] == 0 and graph [k] [j] == 1 and
                                            graph [i] [k] == 1
                then graph [i] [j] = 1
                end
            end
        end
    end

    --
    -- We have a loop iff there is a node which is reachable from itself
    --
    local out = 0
    for i in pairs (nodes)
    do  if   graph [i] [i] == 1
        then out = 1
        end
    end

    print (out)
end
