using Primes
using Combinatorics

function partition(m, n)
    for comb in combinations(primes(m),n)
        sum(comb) == m && println("$m $n: ", comb)
    end
end

partition(18,2)
partition(19, 3)
partition(25, 2)
