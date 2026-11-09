#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Max Positive Negative (The Weekly Challenge 262 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl -3 1 2 -1 3 -2 4
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>.

Write a script to return the maximum number of either positive or negative
integers in the given array.

=head1 FUNCTIONS

=head2 max_positive_negative($ints)

Returns the maximum count between positive integers (C<< > 0 >>) and negative
integers (C<< < 0 >>) in C<$ints>. Zeroes are neither positive nor negative.

=over 4

=item * C<$ints> - Reference to an array of integers.

=back

Returns an integer representing the maximum count.

=cut

signature_for max_positive_negative => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub max_positive_negative ($ints) {
    my $positive_count = scalar( grep { $_ > 0 } @$ints );
    my $negative_count = scalar( grep { $_ < 0 } @$ints );
    return $positive_count > $negative_count ? $positive_count : $negative_count;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints   = map { int($_) } @args;
    my $result = max_positive_negative( \@ints );
    say "Output: $result";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ -3, 1, 2, -1, 3, -2, 4 ],
            expected => 4,
        },
        {
            label    => 'Example 2',
            ints     => [ -1, -2, -3, 1 ],
            expected => 3,
        },
        {
            label    => 'Example 3',
            ints     => [ 1, 2 ],
            expected => 2,
        },
        {
            label    => 'Array with zeroes',
            ints     => [ 0, 0, -1, 1, 2 ],
            expected => 2,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            max_positive_negative( $case->{ints} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
