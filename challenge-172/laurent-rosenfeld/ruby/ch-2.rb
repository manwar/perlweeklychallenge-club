def median(n)
    size = n.length
    if size %2 != 0
        n[(size + 1) / 2]
    else
        (n[size/2] + n[size/2 + 1]) / 2.0
    end
end

def summary(n)
    min = n[0]
    max = n[-1]
    med = median(n)
    first_q = median( n.select { |i| i < med })
    last_q = median( n.select { |i| i > med })
    return min, first_q, med, last_q, max
end

moons = [0, 0, 1, 2, 63, 61, 27, 13]
print summary(moons.sort), "\n"
