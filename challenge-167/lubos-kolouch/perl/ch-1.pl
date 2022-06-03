use strict;
use warnings;
use Math::Prime::Util qw(is_prime next_prime);

sub is_circular_prime {
    my $prime = shift;

    my $digits = length($prime);

    for my $i ( 0 .. $digits - 1 ) {
        return 0 unless is_prime($prime);
        my $digit = substr( $prime, 0, 1 );
        $prime = substr( $prime, 1, $digits - 1 ) . $digit;
    }

    return 1;
}

sub generate_primes {
    my $limit = shift;

    my @primes;
    my $prime = next_prime(100);

    while ( scalar @primes < $limit ) {
        push @primes, $prime if is_circular_prime($prime);
        $prime = next_prime($prime);
    }

    return \@primes;
}

use Test::More;

is( is_circular_prime(2),   1, '2 is a circular prime' );
is( is_circular_prime(3),   1, '3 is a circular prime' );
is( is_circular_prime(11),  1, '11 is a circular prime' );
is( is_circular_prime(13),  1, '13 is a circular prime' );
is( is_circular_prime(57),  0, '57 not a circular prime' );
is( is_circular_prime(197), 1, '197 is a circular prime' );

# Note that the example given on the challenge is wrong according to
# https://oeis.org/A068652

is_deeply(
    generate_primes(10),
    [ 113, 131, 197, 199, 311, 337, 373, 719, 733, 919 ],

    'Generate primes'
);

done_testing();
