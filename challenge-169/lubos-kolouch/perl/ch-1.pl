package main;
use strict;
use warnings;

use Math::Prime::Util qw/factor/;

sub is_brilliant_number {
    my $number = shift;

    my @factors = factor($number);

    if ( ( scalar @factors == 2 ) and ( length( $factors[0] ) == length( $factors[1] ) ) ) {
        return 1;
    }

    return 0;
}

sub generate_brilliant_numbers {
    my $limit = shift;

    my @brilliant_numbers;

    my $i = 0;
    while ( scalar @brilliant_numbers < $limit ) {
        $i++;

        if ( is_brilliant_number($i) ) {
            push @brilliant_numbers, $i;
        }
    }

    return \@brilliant_numbers;
}

use Test::More;

is( is_brilliant_number(2),   0 );
is( is_brilliant_number(4),   1 );
is( is_brilliant_number(6),   1 );
is( is_brilliant_number(187), 1 );

is_deeply( generate_brilliant_numbers(20),
    [ 4, 6, 9, 10, 14, 15, 21, 25, 35, 49, 121, 143, 169, 187, 209, 221, 247, 253, 289, 299 ] );

done_testing;
1;
