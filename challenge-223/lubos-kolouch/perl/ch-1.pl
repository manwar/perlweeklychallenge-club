use strict;
use warnings;

sub count_primes {
    my $n     = shift;
    my @sieve = (1) x ( $n + 1 );
    @sieve[ 0, 1 ] = ( 0, 0 );
    for my $i ( 2 .. sqrt($n) ) {
        if ( $sieve[$i] ) {
            for ( my $j = $i * $i ; $j <= $n ; $j += $i ) {
                $sieve[$j] = 0;
            }
        }
    }
    return scalar grep { $_ } @sieve;
}

print count_primes(20);    # Outputs: 8
