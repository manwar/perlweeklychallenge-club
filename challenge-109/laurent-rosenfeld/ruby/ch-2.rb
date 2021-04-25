input = [1, 2, 3, 4, 5, 6, 7]
for p in input.permutation
    sum = p[0] + p[1]
    if p[1] + p[2] + p[3] == sum and
       p[3] + p[4] + p[5] == sum and
       p[5] + p[6] == sum then
        puts p.join(" ")
    end
end
