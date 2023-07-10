use strict;
use warnings;

sub nth_prime {
    my ($n)    = @_;
    my @primes = (2);
    my $i      = 3;
    while ( @primes < $n ) {
        if ( !grep { $i % $_ == 0 } @primes ) {
            push @primes, $i;
        }
        $i += 2;
    }
    return $primes[-1];
}

print nth_prime(10001), "\n";    # Output: 104743
