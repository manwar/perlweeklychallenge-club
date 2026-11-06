#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Number Game (The Weekly Challenge 268 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, @ints, with even number of elements.

Write a script to create a new array made up of elements of the given array.
Pick the two smallest integers and add it to new array in decreasing order i.e.
high to low. Keep doing until the given array is empty.

=head1 FUNCTIONS

=head2 number_game($ints)

Given an array reference of integers with even length, returns a new array reference
where pairs of smallest elements are placed in decreasing order.

=cut

signature_for number_game => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub number_game ($ints) {
    if ( scalar @$ints % 2 != 0 ) {
        die "Input array must contain an even number of elements\n";
    }

    my @sorted = sort { $a <=> $b } @$ints;
    my @result;

    for ( my $i = 0 ; $i < @sorted ; $i += 2 ) {
        push @result, ( $sorted[ $i + 1 ], $sorted[$i] );
    }

    return \@result;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    _run_tests();
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 2, 5, 3, 4 ],
            expected => [ 3, 2, 5, 4 ],
        },
        {
            label    => 'Example 2',
            ints     => [ 9, 4, 1, 3, 6, 4, 6, 1 ],
            expected => [ 1, 1, 4, 3, 6, 4, 9, 6 ],
        },
        {
            label    => 'Example 3',
            ints     => [ 1, 2, 2, 3 ],
            expected => [ 2, 1, 3, 2 ],
        },
        {
            label    => 'Already sorted',
            ints     => [ 1, 2, 3, 4, 5, 6 ],
            expected => [ 2, 1, 4, 3, 6, 5 ],
        },
        {
            label    => 'Reverse sorted',
            ints     => [ 6, 5, 4, 3, 2, 1 ],
            expected => [ 2, 1, 4, 3, 6, 5 ],
        },
        {
            label    => 'Duplicate elements',
            ints     => [ 5, 1, 5, 1, 2, 2 ],
            expected => [ 1, 1, 2, 2, 5, 5 ],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is_deeply( number_game( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
