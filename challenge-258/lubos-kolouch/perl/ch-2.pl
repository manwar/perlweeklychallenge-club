#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Sum of Values (The Weekly Challenge 258 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 1 2 5 9 11 3
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

You are given an array of integers, C<@ints>, and an integer C<$k>.
Write a script to find the sum of values whose index binary representation
has exactly C<$k> 1-bits set.

=head1 FUNCTIONS

=head2 sum_of_values_with_k_ones($ints, $k)

Calculates the sum of elements in C<$ints> whose 0-based index has
exactly C<$k> set bits in its binary representation.

=over 4

=item * C<$ints> - Array reference of integers.

=item * C<$k> - Required number of 1-bits in the index.

=back

Returns the computed sum as an integer.

=cut

signature_for sum_of_values_with_k_ones => (
    method     => 0,
    positional => [ ArrayRef [Int], Int ],
);

sub sum_of_values_with_k_ones ( $ints, $k ) {
    my $sum = 0;

    for my $index ( 0 .. $#$ints ) {
        my $ones = () = sprintf( '%b', $index ) =~ /1/g;
        $sum += $ints->[$index] if $ones == $k;
    }

    return $sum;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    my $k    = int( shift @args );
    my @ints = map { int($_) } @args;
    say sum_of_values_with_k_ones( \@ints, $k );
    return;
}

sub _run_tests {
    my @cases = (
        {
            label    => 'Example 1: k = 1',
            ints     => [ 2, 5, 9, 11, 3 ],
            k        => 1,
            expected => 17,
        },
        {
            label    => 'Example 2: k = 2',
            ints     => [ 2, 5, 9, 11, 3 ],
            k        => 2,
            expected => 11,
        },
        {
            label    => 'Example 3: k = 0',
            ints     => [ 2, 5, 9, 11, 3 ],
            k        => 0,
            expected => 2,
        },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is(
            sum_of_values_with_k_ones( $case->{ints}, $case->{k} ),
            $case->{expected},
            $case->{label}
        );
    }
    return;
}

_run_cli(@ARGV);

=cut
