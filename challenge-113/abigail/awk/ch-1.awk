#!/usr/bin/awk

#
# See ../README.md
#

#
# Run as: awk -f ch-1.awk < input-file
#

#     
# For a description of the algorithm, and the proof why this is correct:
# https://abigail.github.io/HTML/Perl-Weekly-Challenge/week-113-1.html          
# 

BEGIN {
    split ("1 2 1 2 5 2 1 2 1", gcds)
}

{
    N = $1
    D = $2
    if (D == 0) {
        print (N >= 100 || N % 10 == 0 ? 1 : 0)
        next
    }
    if (N >= 10 * D) {
        print 1
        next
    }
    for (i = 0; i < D / gcds [D]; i ++) {
        T = N - 10 * i - D
        if (T >= 0 && T % D == 0) {
            print 1
            next
        }
    }
    print 0
}
