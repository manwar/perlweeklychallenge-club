max = 20
primes = [2, 3, 5]
primes_h = []
count = len(primes)
for i = 1 to count
    primes_h[string(primes[i])] = i
next
truncatables = primes
candidate = primes[count]
while count < max
    candidate += 2
    not_prime = false
    pos = substr(string(candidate), "0")
    if pos > 0 loop ok
    sq_cand = floor(sqrt(candidate))
    for i in primes
        if candidate % i = 0
            not_prime = true
            exit
        ok
        if i > sq_cand exit ok
    next
    if not_prime loop ok
    add (primes, candidate)
    primes_h[string(candidate)] = 1
    // We've found a prime, now check if truncatable prime
    length = len(string(candidate))
    is_truncatable = true
    for i = 1 to length
        truncated = right(string(candidate), i)
        if isnull(primes_h[truncated])
            is_truncatable = false
            exit
        ok
    next
    if is_truncatable
        add(truncatables, candidate);
        count += 1
    ok

end
for val in truncatables see "" + val + " " next
see " " + nl
