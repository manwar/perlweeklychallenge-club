#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-1.pl - Target Index (The Weekly Challenge 263 Task 1)

=head1 SYNOPSIS

  perl ch-1.pl 2 1 5 3 2 4 2
  perl ch-1.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>, and a target element C<$k>.

Write a script to return the list of indices in the sorted array where the
element is the same as the given target element.

=head1 FUNCTIONS

=head2 find_target_indices($ints, $k)

Returns an array reference of indices where C<$k> appears after sorting C<$ints>.

=over 4

=item * C<$ints> - Reference to an array of integers.

=item * C<$k> - Target integer element.

=back

Returns an array reference of 0-based indices in the sorted array.

=cut

signature_for find_target_indices => (
    method     => 0,
    positional => [ ArrayRef [Int], Int ],
);

sub find_target_indices ( $ints, $k ) {
    my @sorted = sort { $a <=> $b } @$ints;
    my @target_indices = grep { $sorted[$_] == $k } 0 .. $#sorted;
    return \@target_indices;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $k      = shift @args;
    my $result = find_target_indices( \@args, int($k) );
    say 'Output: (' . join( ', ', @$result ) . ')';
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1',
            ints     => [ 1, 5, 3, 2, 4, 2 ],
            k        => 2,
            expected => [ 1, 2 ],
        },
        {
            label    => 'Example 2',
            ints     => [ 1, 2, 4, 3, 5 ],
            k        => 6,
            expected => [],
        },
        {
            label    => 'Example 3',
            ints     => [ 5, 3, 2, 4, 2, 1 ],
            k        => 4,
            expected => [4],
        },
        {
            label    => 'Empty array',
            ints     => [],
            k        => 1,
            expected => [],
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is_deeply(
            find_target_indices( $case->{ints}, $case->{k} ),
            $case->{expected},
            $case->{label}
        );
    }
}

_run_cli(@ARGV);

=cut
