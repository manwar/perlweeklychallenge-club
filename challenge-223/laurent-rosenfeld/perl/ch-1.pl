use strict;
use warnings;
use feature 'say';

sub is_prime {
    my $in = shift;
    for my $i (2..sqrt $in) {
        return 0 if $in % $i == 0;
    }
    return 1;
}
sub count_primes {
    my $n = shift;
    return scalar grep {is_prime $_} 2..$n;
}

for my $test (10, 1, 20) {
    printf "%-3d => %d\n", $test, count_primes $test;
}
