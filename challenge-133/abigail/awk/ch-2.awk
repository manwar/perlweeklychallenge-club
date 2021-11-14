#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-2.awk < input-file
#

function digit_sum (number, sum) {
    sum = 0
    while (number > 0) {
        sum   += number % 10
        number = int (number / 10) 
    }
    return sum
}


#
# Factorize a number, given a set of small primes. This will work
# for numbers up to, but not including, p^2, where p is the smallest
# prime not included in the set. For the given set, the smallest number
# which fails to factorize is 37^2 == 1369.
#
# We'll return a string containing all the factors.
#
function factorize (n, out, i, prime, c) {
    out = ""
    c   = 0

    for (i in small_primes) {
        prime = small_primes [i]
        while (n % prime == 0) {
            out = out prime
            n  /= prime
            c ++
        }
    }
    
    if (n > 1) {
        out = out n
        c ++
    }

    return (c ";" out)
}

BEGIN {
    split ("2 3 5 7 11 13 17 19 23 29 31", small_primes, " ")
}

BEGIN {
    try   = 1
    count = 0
    while (count < 10) {
        split (factorize(try), info, ";")
        if (info [1] > 1 && digit_sum(try) == digit_sum(info [2])) {
            print try
            count ++
        }
        try ++
    }
}
        

