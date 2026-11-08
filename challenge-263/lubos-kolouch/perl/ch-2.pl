#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Merge Items (The Weekly Challenge 263 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl
  # runs the embedded tests

=head1 DESCRIPTION

You are given two 2-D arrays of positive integers, C<$items1> and C<$items2>,
where each element is a pair of C<(item_id, item_quantity)>.

Write a script to return the merged items sorted by C<item_id>.

=head1 FUNCTIONS

=head2 merge_items($items1, $items2)

Merges item quantities by C<item_id> across both input 2-D arrays and returns
them sorted by C<item_id> in ascending order.

=over 4

=item * C<$items1> - Reference to the first 2-D array of C<[item_id, quantity]> pairs.

=item * C<$items2> - Reference to the second 2-D array of C<[item_id, quantity]> pairs.

=back

Returns an array reference of merged C<[item_id, total_quantity]> pairs sorted by C<item_id>.

=cut

signature_for merge_items => (
    method     => 0,
    positional => [ ArrayRef [ ArrayRef [Int] ], ArrayRef [ ArrayRef [Int] ] ],
);

sub merge_items ( $items1, $items2 ) {
    my %merged;
    for my $item ( @$items1, @$items2 ) {
        my ( $item_id, $quantity ) = @$item;
        $merged{$item_id} += $quantity;
    }
    return [ map { [ int($_), $merged{$_} ] } sort { $a <=> $b } keys %merged ];
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            items1   => [ [ 1, 1 ], [ 2, 1 ], [ 3, 2 ] ],
            items2   => [ [ 2, 2 ], [ 1, 3 ] ],
            expected => [ [ 1, 4 ], [ 2, 3 ], [ 3, 2 ] ],
        },
        {
            label    => 'Example 2',
            items1   => [ [ 1, 2 ], [ 2, 3 ], [ 1, 3 ], [ 3, 2 ] ],
            items2   => [ [ 3, 1 ], [ 1, 3 ] ],
            expected => [ [ 1, 8 ], [ 2, 3 ], [ 3, 3 ] ],
        },
        {
            label    => 'Example 3',
            items1   => [ [ 1, 1 ], [ 2, 2 ], [ 3, 3 ] ],
            items2   => [ [ 2, 3 ], [ 2, 4 ] ],
            expected => [ [ 1, 1 ], [ 2, 9 ], [ 3, 3 ] ],
        },
        {
            label    => 'Empty lists',
            items1   => [],
            items2   => [],
            expected => [],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is_deeply(
            merge_items( $case->{items1}, $case->{items2} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_tests();

=cut
