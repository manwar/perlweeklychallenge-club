#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-1.pl - Smallest Index

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 250, Task 1: Smallest Index.
Given an array of integers, finds the smallest index C<i> such that
C<i mod 10 == $ints[i]>, or returns C<-1> if no such index exists.

=head1 FUNCTIONS

=head2 smallest_index($ints)

Returns the smallest index C<i> in the array reference C<$ints> where
C<i % 10 == $ints-E<gt>[$i]>, or C<-1> if none matches.

=cut

signature_for smallest_index => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub smallest_index ($ints) {
    for my $i ( 0 .. $#{$ints} ) {
        return $i if $i % 10 == $ints->[$i];
    }
    return -1;
}

is( smallest_index( [ 0, 1, 2 ] ),                      0,  'Example 1' );
is( smallest_index( [ 4, 3, 2, 1 ] ),                   2,  'Example 2' );
is( smallest_index( [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 0 ] ), -1, 'Example 3' );
is( smallest_index( [] ),                               -1, 'Empty array' );
done_testing();
