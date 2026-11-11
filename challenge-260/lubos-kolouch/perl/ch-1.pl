#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Unique Occurrences (The Weekly Challenge 260 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 1 2 2 1 1 3
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>.

Write a script to return C<1> if the number of occurrences of each value in the
given array is unique or C<0> otherwise.

=head1 FUNCTIONS

=head2 unique_occurrences($ints)

Checks whether the frequency of each distinct integer in C<$ints> is unique.

=over 4

=item * C<$ints> - Reference to an array of integers.

=back

Returns C<1> if all occurrence counts are unique, or C<0> otherwise.

=cut

signature_for unique_occurrences => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub unique_occurrences ($ints) {
    my %count;
    $count{$_}++ for @$ints;

    my %occurrences_count;
    for my $freq ( values %count ) {
        return 0 if $occurrences_count{$freq}++;
    }

    return 1;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints   = map { int($_) } @args;
    my $result = unique_occurrences( \@ints );
    say "Output: $result";
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 1, 2, 2, 1, 1, 3 ],
            expected => 1,
        },
        {
            label    => 'Example 2',
            ints     => [ 1, 2, 3 ],
            expected => 0,
        },
        {
            label    => 'Example 3',
            ints     => [ -2, 0, 1, -2, 1, 1, 0, 1, -2, 9 ],
            expected => 1,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            unique_occurrences( $case->{ints} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
