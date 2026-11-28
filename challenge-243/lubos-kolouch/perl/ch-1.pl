#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-1.pl - Reverse Pairs

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 243, Task 1: Reverse Pairs.
Counts the number of reverse pairs C<(i, j)> in an integer array such that
C<< 0 <= i < j < @nums >> and C<< $nums[$i] > 2 * $nums[$j] >> using a
modified merge sort in O(N log N) time.

=head1 FUNCTIONS

=head2 count_reverse_pairs($nums)

Takes an array reference of integers C<$nums> and returns the total count
of reverse pairs.

=cut

sub _merge_sort ( $nums, $left, $right ) {
    return 0 if $left >= $right;

    my $mid   = int( ( $left + $right ) / 2 );
    my $count = _merge_sort( $nums, $left, $mid )
      + _merge_sort( $nums, $mid + 1, $right );

    my ( $i, $j ) = ( $left, $mid + 1 );
    while ( $i <= $mid ) {
        while ( $j <= $right && $nums->[$i] > 2 * $nums->[$j] ) {
            $j++;
        }
        $count += $j - ( $mid + 1 );
        $i++;
    }

    my @sorted;
    ( $i, $j ) = ( $left, $mid + 1 );
    while ( $i <= $mid && $j <= $right ) {
        if ( $nums->[$i] <= $nums->[$j] ) {
            push @sorted, $nums->[ $i++ ];
        }
        else {
            push @sorted, $nums->[ $j++ ];
        }
    }
    push @sorted, @{$nums}[ $i .. $mid ]   if $i <= $mid;
    push @sorted, @{$nums}[ $j .. $right ] if $j <= $right;
    @{$nums}[ $left .. $right ] = @sorted;

    return $count;
}

signature_for count_reverse_pairs => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub count_reverse_pairs ($nums) {
    my @arr = @{$nums};
    return 0 if scalar @arr < 2;
    return _merge_sort( \@arr, 0, $#arr );
}

is( count_reverse_pairs( [ 1, 3, 2, 3, 1 ] ), 2, 'Example 1' );
is( count_reverse_pairs( [ 2, 4, 3, 5, 1 ] ), 3, 'Example 2' );
done_testing();
