#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-1.pl - Concatenation Value

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 251, Task 1: Concatenation Value.
Repeatedly pairs the first and last elements of an integer array, concatenates
their decimal representations, and sums the resulting values until the array
is exhausted (adding any single remaining middle element directly).

=head1 FUNCTIONS

=head2 concatenation_value($ints)

Returns the concatenation value of the array reference C<$ints> of integers.

=cut

signature_for concatenation_value => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub concatenation_value ($ints) {
    my $concat_value = 0;
    my $left         = 0;
    my $right        = $#{$ints};

    while ( $left < $right ) {
        $concat_value += int( "$ints->[$left]$ints->[$right]" );
        $left++;
        $right--;
    }

    if ( $left == $right ) {
        $concat_value += $ints->[$left];
    }

    return $concat_value;
}

is( concatenation_value( [ 6, 12, 25, 1 ] ),      1286, 'Example 1' );
is( concatenation_value( [ 10, 7, 31, 5, 2, 2 ] ), 489, 'Example 2' );
is( concatenation_value( [ 1, 2, 10 ] ),           112, 'Example 3' );
is( concatenation_value( [42] ),                    42, 'Single element' );
is( concatenation_value( [] ),                       0, 'Empty array' );
done_testing();
