# To run:
# $ julia ch-1.jl 100
# 13015

n = length(ARGS) == 1 ? parse(Int, ARGS[1]) : 3

s = 0
for x in range(1, stop = n)
    for y in range(x + 1, stop = n)
        global s
        s += gcd(x, y)
    end
end

println(s)
