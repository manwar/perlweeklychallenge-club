package main;
use strict;
use warnings;
use Math::Prime::Util qw/factor_exp gcd/;
use List::Util qw/min/;

sub is_achilles_number {

# https://en.wikipedia.org/wiki/Achilles_number
# A number n = p1a1p2a2…pkak is powerful if min(a1, a2, …, ak) ≥ 2. If in addition gcd(a1, a2, …, ak) = 1 the number is an Achilles number.

    my $number = shift;

    my @factors = factor_exp($number);
    my $sum     = 0;

    my @exps;

    for my $factor (@factors) {
        my $e = $factor->[1];

        push @exps, $e;
    }

    return 1 if ( min(@exps) >= 2 ) and ( gcd(@exps) == 1 );

    return 0;
}

sub generate_achilles_numbers {
    my $limit = shift;

    my @achilles_numbers;

    my $i = 2;

    while ( scalar @achilles_numbers < $limit ) {
        push @achilles_numbers, $i if is_achilles_number($i);
        $i++;
    }

    return \@achilles_numbers;
}

use Test::More;

is( is_achilles_number(36), 0 );
is( is_achilles_number(72), 1 );

is_deeply(
    generate_achilles_numbers(20),
    [
        72,  108, 200, 288,  392,  432,  500,  648,  675,  800,
        864, 968, 972, 1125, 1152, 1323, 1352, 1372, 1568, 1800
    ]
);

done_testing;
1;
