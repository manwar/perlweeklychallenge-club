#!/usr/bin/env perl
use v5.38;
use warnings;
use List::Util qw(min max);
use Type::Params -sigs;
use Types::Standard qw(ArrayRef Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Order Game (The Weekly Challenge 286 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 2 1 4 5 6 3 0 2
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

This script simulates the Order Game on a given array of integers whose length is a power of 2.

In the Order Game:

=over 4

=item * At each round, the array is reduced by pairing consecutive elements: C<(ints[2*i], ints[2*i + 1])>.

=item * For each pair, if it is at an even index C<$i> (starting from 0), take the minimum of the pair.

=item * If it is at an odd index C<$i>, take the maximum of the pair.

=item * This process repeats until only one element remains.

=back

=head1 FUNCTIONS

=head2 order_game($ints)

Simulates the Order Game and returns the last remaining element.

=over 4

=item * C<$ints> - Reference to an array of integers (length must be a power of 2).

=back

Returns the last remaining integer after playing the game.

=cut

signature_for order_game => (
    method     => 0,
    positional => [ ArrayRef [Int] ],
);

sub order_game ($ints) {
    my @current_list = @$ints;
    while ( @current_list > 1 ) {
        my @next_list;
        my $pairs = int( @current_list / 2 );
        for my $i ( 0 .. $pairs - 1 ) {
            my $first  = $current_list[ 2 * $i ];
            my $second = $current_list[ 2 * $i + 1 ];
            if ( $i % 2 == 0 ) {

                # Even index: take minimum
                push @next_list, min( $first, $second );
            }
            else {
                # Odd index: take maximum
                push @next_list, max( $first, $second );
            }
        }
        @current_list = @next_list;
    }
    return $current_list[0];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my @ints = map { int($_) } @args;
    my $out  = order_game( \@ints );
    say "Output: $out";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1', ints => [ 2, 1, 4, 5, 6, 3, 0, 2 ],                               expected => 1 },
        { label => 'Example 2', ints => [ 0, 5, 3, 2 ],                                           expected => 0 },
        { label => 'Example 3', ints => [ 9, 2, 1, 4, 5, 6, 0, 7, 3, 1, 3, 5, 7, 9, 0, 8 ], expected => 2 },
        { label => 'Single pair', ints => [ 7, 3 ],                                                expected => 3 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( order_game( $case->{ints} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
