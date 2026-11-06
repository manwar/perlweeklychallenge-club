#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Bitwise OR with Trailing Zero (The Weekly Challenge 269 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 1 2 3 4 5
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of 2 or more positive integers, C<@ints>.

Write a script to find out if it is possible to select two or more elements
of C<@ints> such that the bitwise OR of those elements has at least one trailing
zero in its binary representation.

A binary number has at least one trailing zero if and only if it is even.
The bitwise OR of two or more numbers is even if and only if all selected
numbers are even. Therefore, such a selection of two or more numbers exists
if and only if the array contains at least two even numbers.

=head1 FUNCTIONS

=head2 bitwise_or_with_trailing_zero($ints)

Determines if two or more elements can be selected with a bitwise OR ending in zero.

=over 4

=item * C<$ints> - Reference to an array of positive integers.

=back

Returns 1 if possible, 0 otherwise.

=cut

signature_for bitwise_or_with_trailing_zero => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub bitwise_or_with_trailing_zero ($ints) {
    my $even_count = 0;
    for my $val (@$ints) {
        if ( $val % 2 == 0 ) {
            $even_count++;
            return 1 if $even_count >= 2;
        }
    }
    return 0;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = bitwise_or_with_trailing_zero( \@ints );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 1, 2, 3, 4, 5 ],
            expected => 1,
        },
        {
            label    => 'Example 2',
            ints     => [ 2, 3, 8, 16 ],
            expected => 1,
        },
        {
            label    => 'Example 3',
            ints     => [ 1, 2, 5, 7, 9 ],
            expected => 0,
        },
        {
            label    => 'No trailing zero (all odd)',
            ints     => [ 1, 3, 5, 7, 9 ],
            expected => 0,
        },
        {
            label    => 'All even',
            ints     => [ 2, 4, 6, 8, 10 ],
            expected => 1,
        },
        {
            label    => 'Minimal two evens',
            ints     => [ 4, 6 ],
            expected => 1,
        },
        {
            label    => 'Minimal one even',
            ints     => [ 3, 4 ],
            expected => 0,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( bitwise_or_with_trailing_zero( $case->{ints} ), $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
