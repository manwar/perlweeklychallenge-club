using Primes
function fortunate_numbers( wanted::Integer )
    out = []
    prime_product::BigInt = 1
    for p in nextprimes(BigInt)
        prime_product *= p
        euclid = prime_product + 1

        push!(out, nextprime(euclid+1) - euclid + 1)

        if length(out) > wanted
            break
        end
    end
    
    return out
end
@assert fortunate_numbers(20) == [3,5,7,13,23,17,19,23,37,61,67,61,71,47,107,59,61,109,89,103,79]

fn8 = unique(sort(fortunate_numbers(8)))
println(fn8)
