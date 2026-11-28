#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Floor Sum

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 243, Task 2: Floor Sum.
Computes the sum of C<floor(nums[i] / nums[j])> over all pairs C<(i, j)>
in an array of positive integers.

=head1 FUNCTIONS

=head2 floor_sum($nums)

Takes an array reference of positive integers C<$nums> and returns the sum
of C<int($nums->[$i] / $nums->[$j])> for all index pairs.

=cut

signature_for floor_sum => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub floor_sum ($nums) {
    my $sum = 0;
    for my $a ( @{$nums} ) {
        for my $b ( @{$nums} ) {
            $sum += int( $a / $b );
        }
    }
    return $sum;
}

is( floor_sum( [ 2, 5, 9 ] ),             10, 'Example 1' );
is( floor_sum( [ 7, 7, 7, 7, 7, 7, 7 ] ), 49, 'Example 2' );
done_testing();
