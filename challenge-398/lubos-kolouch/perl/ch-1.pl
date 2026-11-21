#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-1.pl - Divisible Average

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 398, Task 1: Divisible Average.
Given an array of positive integers, returns the closest integer to the mean
value of all even integers divisible by 3, or C<0> if none qualify.

=head1 FUNCTIONS

=head2 divisible_average($arr)

Returns the rounded mean of all elements in C<$arr> that are divisible by 6,
or C<0> if no such element exists.

=cut

signature_for divisible_average => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub divisible_average ($arr) {
    my $sum   = 0;
    my $count = 0;

    for my $num ( @{$arr} ) {
        if ( $num % 6 == 0 ) {
            $sum += $num;
            $count++;
        }
    }

    return 0 if $count == 0;
    return int( ( $sum / $count ) + 0.5 );
}

is( divisible_average( [ 18, 5, 7, 11 ] ),        18, 'Example 1' );
is( divisible_average( [ 6, 12, 18, 24, 30, 40 ] ), 18, 'Example 2' );
is( divisible_average( [ 3, 9, 15, 21, 27 ] ),     0, 'Example 3' );
is( divisible_average( [ 6, 12, 14, 20 ] ),        9, 'Example 4' );
is( divisible_average( [ 6, 6, 6, 12, 12 ] ),      8, 'Example 5' );
done_testing();
