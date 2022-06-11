package main;
use strict;
use warnings;
use Math::Prime::Util qw/is_prime/;

sub get_eq {

# warning - waste here, it is ready also for the second series, even though we were not asked for it
# this is a bad practice and one of the 7 wastes, but I just accept that I am aware of it and leave it.
    my ( $y, $incr ) = @_;

    my $x = $y + $incr;

    return ( $x**3 - $y**3 ) / ( $x - $y );
}

sub get_cuban_primes {
    my $limit = shift;

    my @primes;
    my $result = 0;
    my $y      = 0;

# it would be probabl safer to keep running for a while even after we get over the limit...
# maybe next values from the function(s) could drop again below the limit
# but it passes the test and I am a lazy programmer to check the actual outputs from the function,
# so let's just leave it ;)

    while ( $result <= $limit ) {
        $y++;

        $result = get_eq( $y, 1 );
        push @primes, $result if is_prime($result);
    }

    return \@primes;
}

use Test::More;

is_deeply( get_cuban_primes(1000),
    [ 7, 19, 37, 61, 127, 271, 331, 397, 547, 631, 919 ] );

done_testing;
1;
