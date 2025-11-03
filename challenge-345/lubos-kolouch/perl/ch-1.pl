#!/usr/bin/env perl
use strict;
use warnings;
use feature qw(signatures state);
no warnings qw(experimental::signatures);
use Type::Params    qw(compile);
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 PURPOSE

Identify every peak in the supplied integer array. A peak is any element
that is strictly greater than its immediate neighbours. The first and last
elements are peaks if they are strictly greater than their single neighbour.

=head1 ALGORITHM

We validate the input with L<Type::Params> to ensure an array reference of
integers. Iterating once over the array, we compare each element with its
left and right neighbours where they exist. Indices meeting the peak
predicate are collected and returned as an array reference.

=cut

## no critic (Subroutines::ProhibitSubroutinePrototypes)
sub peak_positions ($ints_ref) {
    state $check = compile( ArrayRef [Int] );
    my ($ints) = $check->($ints_ref);

    my @peaks;
    for my $idx ( 0 .. $#$ints ) {
        my $current = $ints->[$idx];
        my $left    = $idx > 0       ? $ints->[ $idx - 1 ] : undef;
        my $right   = $idx < $#$ints ? $ints->[ $idx + 1 ] : undef;

        next if defined($left)  && $current <= $left;
        next if defined($right) && $current <= $right;

        push @peaks, $idx;
    }

    return \@peaks;
}

# Example tests provided by the specification.
is_deeply( peak_positions( [ 1, 3, 2 ] ),             [1],         'Example 1' );
is_deeply( peak_positions( [ 2, 4, 6, 5, 3 ] ),       [2],         'Example 2' );
is_deeply( peak_positions( [ 1, 2, 3, 2, 4, 1 ] ),    [ 2, 4 ],    'Example 3' );
is_deeply( peak_positions( [ 5, 3, 1 ] ),             [0],         'Example 4' );
is_deeply( peak_positions( [ 1, 5, 1, 5, 1, 5, 1 ] ), [ 1, 3, 5 ], 'Example 5' );

done_testing();
