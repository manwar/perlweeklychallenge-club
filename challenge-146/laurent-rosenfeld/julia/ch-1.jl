function getprimes(max)
    primes = [2, 3, 5]
    count = 3
    candidate = 5
    while (count <= max)
        candidate += 2
        not_prime = false
        sq_cand = sqrt(candidate)
        for i in primes
            if (candidate % i == 0)
                not_prime = true
                break
            end
            i > max && break
        end
        not_prime && continue
        push!(primes, candidate)
        count += 1
    end
    return primes[max] # Julia arrays start with index 1
end

p = getprimes(10001)
println(p)
