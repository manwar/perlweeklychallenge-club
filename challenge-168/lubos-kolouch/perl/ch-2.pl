use strict;
use warnings;
use Math::Prime::Util qw/is_prime factor/;

sub home_prime {
    my $n = shift;

    while ( !is_prime($n) ) {
        my @factors = factor($n);
        my $sum     = '';
        foreach my $factor (@factors) {
            $sum .= $factor;
        }
        $n = $sum;
    }

    return $n;
}

use Test::More;

is( home_prime(2),  2 );
is( home_prime(10), 773 );
done_testing;
