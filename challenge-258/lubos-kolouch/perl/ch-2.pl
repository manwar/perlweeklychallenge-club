#!/usr/bin/perl
use strict;
use warnings;

sub sum_of_values_with_k_ones {
    my ( $arr_ref, $k ) = @_;
    my $sum = 0;

    for my $index ( 0 .. $#$arr_ref ) {
        $sum += $arr_ref->[$index] if scalar( grep { $_ } split //, sprintf "%b", $index ) == $k;
    }

    return $sum;
}

# Testing the function with the provided examples
my @ints = ( 2, 5, 9, 11, 3 );
print sum_of_values_with_k_ones( \@ints, 1 ), "\n";    # Output: 17
print sum_of_values_with_k_ones( \@ints, 2 ), "\n";    # Output: 11
print sum_of_values_with_k_ones( \@ints, 0 ), "\n";    # Output: 2
