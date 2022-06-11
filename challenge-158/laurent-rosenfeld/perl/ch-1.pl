use strict;
use warnings;
use feature "say";

my @small_primes = (2, 3, 5, 7);

sub is_prime {
    my $n = shift;
    for my $p (@small_primes) {
        return 1 if $p == $n;
        return 0 if $n % $p == 0;
    }
    return 1;
}

for my $n (grep {is_prime $_} 2..100) {
    my $sum = 0;
    $sum += $_ for split '', $n;
    print "$n " if is_prime $sum;
}
say "";
