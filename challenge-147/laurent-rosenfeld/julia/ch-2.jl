max = 4000
pentanums = map((x) -> Int(x * (3 * x -1)/2), 1:max)
penta_h = Dict(map((x) -> Int(x * (3 * x -1)/2) => x, 1:max))
for i in 1:4000-1
    for j in (i + 1):4000-1
        sum = pentanums[i] + pentanums[j]
        if (haskey(penta_h, Int(sum)) == 0)
            continue
        end
        diff = pentanums[i] - pentanums[j]
        # if (haskey(penta_h, Int(diff)) == 0)
        #    continue
        # end
        println(i, " ", j, " ", pentanums[i], " ", pentanums[j], " ", sum)
    end
end
