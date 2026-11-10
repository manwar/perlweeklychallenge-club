#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Multiply by Two (The Weekly Challenge 261 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 3 5 3 6 1 12
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>, and an integer C<$start>.

Write a script to do the following:
a) Look for C<$start> in the array C<@ints>, if found multiply the number by 2
b) If not found stop the process, otherwise repeat

In the end return the final value.

=head1 FUNCTIONS

=head2 multiply_by_two($ints, $start)

Repeatedly doubles C<$start> as long as the current value of C<$start> exists
in C<$ints>, and returns the final value.

=over 4

=item * C<$ints> - Reference to an array of integers.

=item * C<$start> - Initial integer value.

=back

Returns the final integer value after doubling stops.

=cut

signature_for multiply_by_two => (
    method     => 0,
    positional => [ ArrayRef [Int], Int ],
);

sub multiply_by_two ( $ints, $start ) {
    my %seen = map { $_ => 1 } @$ints;

    while ( $seen{$start} ) {
        $start *= 2;
    }

    return $start;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $start  = int( shift @args );
    my @ints   = map { int($_) } @args;
    my $result = multiply_by_two( \@ints, $start );
    say "Output: $result";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 5, 3, 6, 1, 12 ],
            start    => 3,
            expected => 24,
        },
        {
            label    => 'Example 2',
            ints     => [ 1, 2, 4, 3 ],
            start    => 1,
            expected => 8,
        },
        {
            label    => 'Example 3',
            ints     => [ 5, 6, 7 ],
            start    => 2,
            expected => 2,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            multiply_by_two( $case->{ints}, $case->{start} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
