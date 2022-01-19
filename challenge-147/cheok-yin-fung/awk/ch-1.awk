# The Weekly Challenge 147
# Task 1 Truncatable Prime
# Instructions: Print the first 20 left truncatable primes.
# Usage: awk -f 'ch-1.awk'

BEGIN {
    target_size = 20
    prime[0] = 2
    prime[1] = 3
    prime[2] = 5
    prime[3] = 7

    i = 4
    for (n=10; n < 1000; n++) {
        loop = 1
        for (k=2; k < n/3 && loop == 1; k++) {
            if (n % k == 0)
                loop = 0
        }
        if (loop == 1) {
            prime[i] = n
            i++
        }
    }

    i=0
    for (n in prime) {
        loop = 0
        for (k in prime) {
            if (prime[n] % 10 == prime[k] && prime[k] < 10) {
                loop++
            }
            if (prime[n] % 100 == prime[k] && prime[k] < 100) {
                loop++
            }
        }
        if (loop == 2) {
            print prime[n]
            i++
        }
        if (i > target_size) {
            exit
        }
    }

} 
