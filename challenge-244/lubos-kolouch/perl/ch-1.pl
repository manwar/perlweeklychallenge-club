#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-1.pl - Count Smaller

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 244, Task 1: Count Smaller.
Given an array of integers, calculates the number of integers smaller than the
integer at each index.

=head1 FUNCTIONS

=head2 count_smaller($nums)

Returns an array reference where each element at index C<$i> is the count of
elements in C<$nums> strictly smaller than C<< $nums->[$i] >>.

=cut

signature_for count_smaller => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub count_smaller ($nums) {
    my @result;
    for my $i ( 0 .. $#$nums ) {
        my $count = 0;
        for my $j ( 0 .. $#$nums ) {
            $count++ if $nums->[$j] < $nums->[$i] && $j != $i;
        }
        push @result, $count;
    }

    return \@result;
}

is_deeply( count_smaller( [ 8, 1, 2, 2, 3 ] ), [ 4, 0, 1, 1, 3 ], 'Example 1' );
is_deeply( count_smaller( [ 6, 5, 4, 8 ] ),    [ 2, 1, 0, 3 ],    'Example 2' );
is_deeply( count_smaller( [ 2, 2, 2 ] ),       [ 0, 0, 0 ],       'Example 3' );
done_testing();
