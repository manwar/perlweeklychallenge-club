#!/usr/bin/perl
use strict;
use warnings;

sub count_even_digits {
    my (@ints) = @_;
    my $even_digits_count = 0;

    foreach my $num (@ints) {
        if ( length( join "", split //, $num ) % 2 == 0 ) {
            $even_digits_count++;
        }
    }

    return $even_digits_count;
}

# Assert tests
use Test::More;
is( count_even_digits( 10, 1, 111, 24, 1000 ),
    3, "Test Case  1: Count of integers with even number of digits" );
is( count_even_digits( 111, 1, 11111 ), 0, "Test Case  2: Count of integers with even number of digits" );
is( count_even_digits( 2, 8, 1024, 256 ), 1, "Test Case  3: Count of integers with even number of digits" );
done_testing();
