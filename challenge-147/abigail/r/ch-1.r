#!/usr/local/bin/Rscript

#
# See https://theweeklychallenge.org/blog/perl-weekly-challenge-147
#

#
# Run as: Rscript ch-1.r
#

suppressPackageStartupMessages (
    library (gmp)
)

todo = c (2, 3, 5, 7)
cat (todo, "")

count = 20 - length (todo)

pow = 10
while (count > 0 && length (todo) > 0) {
    new_todo = c ()
    for (d in 1 : 9) {
        for (p in todo) {
            candidate = d * pow + p
            if (isprime (candidate) > 0) {
                cat (candidate, "")
                count = count - 1
                new_todo = c (new_todo, candidate)
                if (count <= 0) {
                    break
                }
            }
            if (count <= 0) {
                break
            }
        }
        if (count <= 0) {
            break
        }
    }
    pow = pow * 10
    todo = new_todo
}

cat ("\n")
