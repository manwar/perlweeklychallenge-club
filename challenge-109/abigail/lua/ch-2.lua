#!/opt/local/bin/lua

--
-- See ../README.md
--

--
-- Run as: lua ch-2.lua < input-file
--

local SIZE = 7

for line in io . lines () do
    local numbers = {}
    for n in line : gmatch ("-?%d+") do
        numbers [#numbers + 1] = tonumber (n)
    end

    --
    -- Initialize the a differences table.
    --
    local differences = {}
    for n_i, n in pairs (numbers) do
        differences [n] = {}
    end

    -- 
    -- Find all the differences; store the indices of the
    -- pairs of numbers giving the difference. Ignore a difference
    -- which is not present in the numbers array.
    --
    for i = 1, SIZE do
        for j = i + 1, SIZE do
            local diff = numbers [i] - numbers [j]
            if   differences [ diff] ~= nil
            then table . insert (differences [ diff], {i, j})
            end
            if   differences [-diff] ~= nil
            then table . insert (differences [-diff], {j, i})
            end
        end
    end

    --
    -- For each possible value d, find the pairs of differences
    -- equal to d, such that all five numbers are difference.
    --

    for d_i = 1, SIZE do
        local d     = numbers [d_i]
        local diffs = differences [d]

        for x = 1, #diffs do
            --
            -- Ignore any difference involving d_i
            --
            if   diffs [x] [1] == d_i or diffs [x] [2] == d_i
            then goto end_x
            end
            for y = x + 1, #diffs do
                --
                -- Second difference cannot involve the number at d_i,
                -- and the indices involved in the second difference
                -- must be different from the first difference.
                --
                if   diffs [y] [1] == d_i or diffs [y] [2] == d_i or
                     diffs [x] [1] ==        diffs [y] [1]        or
                     diffs [x] [1] ==        diffs [y] [2]        or
                     diffs [x] [2] ==        diffs [y] [1]        or
                     diffs [x] [2] ==        diffs [y] [2]
                then goto end_y
                end

                --
                -- W.l.o.g. we can now assume diffs [x] are
                -- the indices for a and c, and diffs [y]
                -- are the indices for g and e.
                --
                local a_i = diffs [x] [1]
                local c_i = diffs [x] [2]
                local g_i = diffs [y] [1]
                local e_i = diffs [y] [2]

                --
                -- Try the remaining indices for b_i and f_i
                --
                for b_i = 1, SIZE do
                    if   b_i == a_i or b_i == c_i or b_i == d_i or
                         b_i == e_i or b_i == g_i
                    then goto end_bi
                    end
                    for f_i = 1, SIZE do
                        if   f_i == a_i or f_i == b_i or f_i == c_i or
                             f_i == d_i or f_i == e_i or f_i == g_i
                        then goto end_fi
                        end
                        --
                        -- Do we have a winner?
                        --
                        local target = numbers [a_i] + numbers [b_i]
                        if   target == numbers [b_i] + numbers [c_i] +
                                       numbers [d_i]   and
                             target == numbers [d_i] + numbers [e_i] +
                                       numbers [f_i]   and
                             target == numbers [f_i] + numbers [g_i]
                        then --
                             -- We have a winner. Print it, and its reverse
                             --
                             io . write (
                                  string . format ("%d %d %d %d %d %d %d\n",
                                           numbers [a_i], numbers [b_i],
                                           numbers [c_i], numbers [d_i],
                                           numbers [e_i], numbers [f_i],
                                           numbers [g_i]))
                             io . write (
                                  string . format ("%d %d %d %d %d %d %d\n",
                                           numbers [g_i], numbers [f_i],
                                           numbers [e_i], numbers [d_i],
                                           numbers [c_i], numbers [b_i],
                                           numbers [a_i]))
                        end
                        ::end_fi::
                    end
                    ::end_bi::
                end
                ::end_y::
            end
            ::end_x::
        end
    end
end
