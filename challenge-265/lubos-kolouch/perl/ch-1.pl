#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - 33% Appearance (The Weekly Challenge 265 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 1 2 3 3 3 3 4 2
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>.

Write a script to find an integer that appears 33% or more of the time in the given array.
If there is more than one such integer, return the smallest integer.
If no such integer exists or the array is empty, return undef.

=head1 FUNCTIONS

=head2 find_integer_appearing_33_percent_or_more($ints)

Finds the smallest integer appearing at least 33% of the time in the given array.

=over 4

=item * C<$ints> - Reference to an array of integers.

=back

Returns the smallest qualifying integer, or undef if none found.

=cut

signature_for find_integer_appearing_33_percent_or_more => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub find_integer_appearing_33_percent_or_more ($ints) {
    return unless @$ints;

    my $n = scalar @$ints;
    my %count;
    $count{$_}++ for @$ints;

    my @valid_numbers = grep { ( $count{$_} / $n ) >= 0.33 } keys %count;
    return unless @valid_numbers;

    @valid_numbers = sort { $a <=> $b } @valid_numbers;
    return $valid_numbers[0];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints   = map { int($_) } @args;
    my $result = find_integer_appearing_33_percent_or_more( \@ints );
    say defined $result ? "Output: $result" : "Output: undef";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 1, 2, 3, 3, 3, 3, 4, 2 ],
            expected => 3,
        },
        {
            label    => 'Example 2',
            ints     => [ 1, 1 ],
            expected => 1,
        },
        {
            label    => 'Example 3',
            ints     => [ 1, 2, 3 ],
            expected => 1,
        },
        {
            label    => 'Empty list',
            ints     => [],
            expected => undef,
        },
        {
            label    => 'No integer reaches 33%',
            ints     => [ 1, 2, 3, 4 ],
            expected => undef,
        },
        {
            label    => 'Tie picks smallest integer',
            ints     => [ 5, 5, 2, 2 ],
            expected => 2,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( find_integer_appearing_33_percent_or_more( $case->{ints} ),
            $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=cut
