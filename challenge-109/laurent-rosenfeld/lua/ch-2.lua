local function check_square (p)
    sum = p[1] + p[2]
    return p[2] + p[3] + p[4] == sum and
        p[4] + p[5] + p[6] == sum and
        p[6] + p[7] == sum
end

local function permute(perm, n)
    if n == 0  and check_square(perm) then
        print( table.concat(perm, ' ') )
    else
        for i = 1, n do
            perm[i], perm[n] = perm[n], perm[i]
            permute(perm, n - 1)
            perm[i], perm[n] = perm[n], perm[i]
        end
    end
end

permute({1,2,3,4,5,6,7}, 7)
