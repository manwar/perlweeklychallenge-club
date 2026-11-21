#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(max min);
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-2.pl - Lucky Numbers

=head1 SYNOPSIS

    perl ch-2.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 251, Task 2: Lucky Numbers.
Given an m x n matrix of distinct numbers, returns the lucky number (an element
that is the minimum in its row and the maximum in its column), or -1 if none
exists.

=head1 FUNCTIONS

=head2 lucky_number($matrix)

Returns the lucky number in the 2D array reference C<$matrix>, or C<-1> if no
such element exists.

=cut

signature_for lucky_number => (
    method     => 0,
    positional => [ ArrayRef [ ArrayRef [Int] ] ],
);

sub lucky_number ($matrix) {
    for my $row ( @{$matrix} ) {
        next if !@{$row};
        my $min_row   = min( @{$row} );
        my ($min_idx) = grep { $row->[$_] == $min_row } 0 .. $#{$row};
        my $max_col   = max( map { $_->[$min_idx] } @{$matrix} );
        return $min_row if $min_row == $max_col;
    }
    return -1;
}

is(
    lucky_number( [ [ 3, 7, 8 ], [ 9, 11, 13 ], [ 15, 16, 17 ] ] ),
    15,
    'Example 1',
);
is(
    lucky_number( [ [ 1, 10, 4, 2 ], [ 9, 3, 8, 7 ], [ 15, 16, 17, 12 ] ] ),
    12,
    'Example 2',
);
is(
    lucky_number( [ [ 7, 8 ], [ 1, 2 ] ] ),
    7,
    'Example 3',
);
is(
    lucky_number( [ [ 3, 1 ], [ 2, 4 ] ] ),
    -1,
    'No lucky number',
);
done_testing();
