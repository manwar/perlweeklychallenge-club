p = primes(10001)
see p + nl

func primes max
    primes = [2, 3, 5]
    count = len(primes)
    candidate = primes[count]
    while count < max
        candidate += 2
        is_prime = True
        sqrt_cand = sqrt(candidate)
        for i in primes
            if candidate % i = 0
                is_prime = False
                exit
            ok
            if i > sqrt_cand exit ok
        next
        if is_prime
            add(primes, candidate)
            count ++
        ok
    end
    return primes[max]
