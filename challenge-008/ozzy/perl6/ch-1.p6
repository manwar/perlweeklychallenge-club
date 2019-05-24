#/usr/bin/env perl6

# Print the first six "perfect numbers" using Euclid's finding
# that 2^(p−1) * (2^p − 1) is an even perfect number whenever
# 2p − 1 is prime, and the fact that odd perfect numbers do not
# exist below 10^1500.
#
# See also:
#   https://en.wikipedia.org/wiki/Perfect_number
#   http://mathworld.wolfram.com/PerfectNumber.html

for 1..17 -> $p {

    my $b = (2**$p -1);
    say "$p : { 2**($p-1) * $b }" if $b.is-prime;

}
