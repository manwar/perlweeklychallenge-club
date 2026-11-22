#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=head1 NAME

ch-1.pl - Equal Pairs

=head1 SYNOPSIS

    perl ch-1.pl

=head1 DESCRIPTION

Solution for The Weekly Challenge 249, Task 1: Equal Pairs.
Given an array of integers with an even number of elements, divides the
array into equal pairs such that each element belongs to exactly one pair
and both elements in a pair are equal. Returns an empty array reference if
no valid pairing exists.

=head1 FUNCTIONS

=head2 equal_pairs($ints)

Takes an array reference of integers C<$ints> and returns an array reference
of two-element array references representing equal pairs, preserving the
first-occurrence order of distinct values, or C<[]> if any value has an odd
frequency.

=cut

signature_for equal_pairs => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub equal_pairs ($ints) {
    my %freq;
    my @order;

    for my $int ( @{$ints} ) {
        if ( !exists $freq{$int} ) {
            push @order, $int;
        }
        $freq{$int}++;
    }

    for my $key (@order) {
        return [] if $freq{$key} % 2;
    }

    my @pairs;
    for my $key (@order) {
        push @pairs, ( [ $key, $key ] ) x ( $freq{$key} / 2 );
    }

    return \@pairs;
}

is_deeply(
    equal_pairs( [ 3, 2, 3, 2, 2, 2 ] ),
    [ [ 3, 3 ], [ 2, 2 ], [ 2, 2 ] ],
    'Example 1'
);
is_deeply( equal_pairs( [ 1, 2, 3, 4 ] ), [], 'Example 2' );
is_deeply( equal_pairs( [] ),             [], 'Empty array' );
done_testing();
