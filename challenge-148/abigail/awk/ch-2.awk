#!/usr/bin/awk

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-148
#

#
# Run as: awk -f ch-2.awk
#


BEGIN {
    COUNT = 5
    #
    # Initialize out with high values.
    # [1, 2, 3] will be values of the triples, [4] will be the sum
    #
    for (i = 1; i <= COUNT; i ++) {
        out [i, 4] = 0
        for (j = 1; j <= 3; j ++) {
            out [i, j]  = 999999
            out [i, 4] += out [i, j]
        }
    }

    max_index = 1  # Index of largest sum

    for (k = 0; 3 * k + 2 <= out [max_index, 4]; k ++) {
        a  = 3 * k + 2
        f1 =     k + 1
        f2 = 8 * k + 5

        d1c = 0
        d2c = 0

        #
        # Find divisors of f1
        #
        for (i = 1; i * i <= f1; i ++) {
            if (f1 % i == 0) {
                d1c = d1c + 1
                d1 [d1c] = i
                if (i != f1 / i) {
                    d1c = d1c + 1
                    d1 [d1c] = f1 / i
                }
            }
        }

        #
        # Find divisors for f2, which are squares
        #
        for (i = 1; i * i <= f2; i ++) {
            if (f2 % i == 0) {
                s1 = sqrt (i)
                s2 = sqrt (f2 / i)
                if (s1 == int (s1)) {
                    d2c = d2c + 1
                    d2 [d2c] = s1
                }
                if (s2 == int (s2) && s1 != s2) {
                    d2c = d2c + 1
                    d2 [d2c] = s2
                }
            }
        }

        for (i = 1; i <= d1c; i ++) {
            for (j = 1; j <= d2c; j ++) {
                b = d1 [i] * d2 [j]
                c = f1 * f1 * f2 / (b * b)
                if (a + b + c < out [max_index, 4]) {
                    #
                    # Skip duplicates
                    #
                    seen = 0
                    for (m = 1; m <= COUNT; m ++) {
                        if (out [m, 1] == a && out [m, 2] == b) {
                            seen = 1
                        }
                    }
                    if (seen) {
                        break
                    }

                    out [max_index, 1] = a
                    out [max_index, 2] = b
                    out [max_index, 3] = c
                    out [max_index, 4] = a + b + c
                
                    #
                    # Find the new max_index
                    #
                    max_index = 1
                    max_sum   = out [max_index, 4]
                    for (l = 2; l <= COUNT; l ++) {
                        if (out [l, 4] > max_sum) {
                            max_sum   = out [l, 4]
                            max_index = l
                        }
                    }
                }
            }
        }
    }

    #
    # Print the array
    #
    for (i = 1; i <= COUNT; i ++) {
        printf ("%d %d %d\n", out [i, 1], out [i, 2], out [i, 3])
    }
}
