primes = Dict(2 => 1, 3 => 1, 5 => 1, 7 => 1, 11 => 1, 13 => 1, 17 => 1, 19 => 1)
count = 0
for n in 2:20
    n_bin = string(n, base=2)
    num_1 = 0
    for digit in n_bin
        num_1 += parse(Int64, digit)
    end
    if num_1 ∈ keys(primes)
        global count
        count += 1
        print(n, " ")
        count >= 10 && break
    end
end
println("")
