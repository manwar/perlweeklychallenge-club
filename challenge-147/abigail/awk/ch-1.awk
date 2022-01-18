#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: awk -f ch-1.awk
#

func is_prime (n, i) {
    if (n % 2 == 0) {return 0}
    for (i = 3; i <= sqrt (n); i += 2) {
        if (n % i == 0) {
            return 0
        }
    }
    return 1
}

BEGIN {
    todo [1] = 2
    todo [2] = 3
    todo [3] = 5
    todo [4] = 7
    n = 4
    i = 1
    count = 20 - n;

    printf ("2 3 5 7 ")

    low  = 1
    high = n
    while (count > 0) {
        for (d = 1; d <= 9 && count > 0; d ++) {
            for (i = low; i <= high && count > 0; i ++) {
                candidate = d todo [i]
                if (is_prime(candidate) == 1) {
                    printf candidate " "
                    count --;
                    todo [++ n] = candidate;
                }
            }
        }
        low  = high + 1
        high = n
    }
    printf ("\n")
}



