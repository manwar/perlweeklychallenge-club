#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Element Digit Sum (The Weekly Challenge 261 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 1 2 3 45
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>.

Write a script to evaluate the absolute difference between element and digit
sum of the given array.

=head1 FUNCTIONS

=head2 element_digit_sum($ints)

Calculates the absolute difference between the sum of all elements in C<$ints>
and the sum of all digits of the elements in C<$ints>.

=over 4

=item * C<$ints> - Reference to an array of integers.

=back

Returns an integer representing the absolute difference.

=cut

signature_for element_digit_sum => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub element_digit_sum ($ints) {
    my $element_sum = 0;
    my $digit_sum   = 0;

    for my $int (@$ints) {
        $element_sum += $int;
        $digit_sum   += $_ for split //, abs($int);
    }

    return abs( $element_sum - $digit_sum );
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints   = map { int($_) } @args;
    my $result = element_digit_sum( \@ints );
    say "Output: $result";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 1, 2, 3, 45 ],
            expected => 36,
        },
        {
            label    => 'Example 2',
            ints     => [ 1, 12, 3 ],
            expected => 9,
        },
        {
            label    => 'Example 3',
            ints     => [ 1, 2, 3, 4 ],
            expected => 0,
        },
        {
            label    => 'Example 4',
            ints     => [ 236, 416, 336, 350 ],
            expected => 1296,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            element_digit_sum( $case->{ints} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
