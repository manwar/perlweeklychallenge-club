use Prime::Factor;

# https://oeis.org/A052486  Achilles numbers
constant @Achilles-numbers = (2 .. Inf).grep: {
    my @v = .&prime-factors.Bag.values;

    @v.min > 1 && ([gcd] @v) == 1;
}


use Test;
plan 1;
is-deeply @Achilles-numbers.head(20), (72, 108, 200, 288, 392, 432, 500, 648, 675, 800, 864, 968, 972, 1125, 1152,1323, 1352, 1372, 1568, 1800).Seq;

# The line below produces md5-exact match for https://oeis.org/A052486/b052486.txt , in 2h7m44s :
# say .key + 1, ' ', .value for @Achilles-numbers.head(10000).pairs;
