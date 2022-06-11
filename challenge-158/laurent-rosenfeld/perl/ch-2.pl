use strict;
use warnings;
use feature "say";

my @small_primes = (2, 3, 5, 7, 11,13, 17, 19, 23, 29, 31);

sub is_prime {
    my $n = shift;
    for my $p (@small_primes) {
        return 1 if $p == $n;
        return 0 if $n % $p == 0;
    }
    return 1;
}

for my $n (1..50) {
    my $p = 3 * $n ** 2 + 3 * $n + 1;
    last if $p > 1000;
    print "$p, " if is_prime $p;
}
say " ";
