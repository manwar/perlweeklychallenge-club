#!/usr/bin/env perl
use v5.38;
use warnings;
use Type::Params -sigs;
use Types::Standard qw(Int);
use Test::More;

=pod

=head1 NAME

ch-2.pl - Making Change (The Weekly Challenge 285 Task 2)

=head1 SYNOPSIS

  perl ch-2.pl 15
  perl ch-2.pl   # runs the embedded tests

=head1 DESCRIPTION

This script computes the number of distinct ways to make change for a given
amount in cents using US coins:

=over 4

=item * Penny (P): 1 cent

=item * Nickel (N): 5 cents

=item * Dime (D): 10 cents

=item * Quarter (Q): 25 cents

=item * Half-dollar (HD): 50 cents

=back

Order of coin selection does not matter.

=head1 FUNCTIONS

=head2 making_change($amount)

Computes the number of distinct ways to make change for the given amount.

=over 4

=item * C<$amount> - The amount in cents (non-negative integer).

=back

Returns the number of distinct ways to make change.

=cut

signature_for making_change => (
    method     => 0,
    positional => [Int],
);

sub making_change ($amount) {
    die 'Amount must be non-negative' if $amount < 0;

    my @coins = ( 1, 5, 10, 25, 50 );
    my @dp    = (0) x ( $amount + 1 );
    $dp[0] = 1;

    for my $coin (@coins) {
        for my $i ( $coin .. $amount ) {
            $dp[$i] += $dp[ $i - $coin ];
        }
    }

    return $dp[$amount];
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $amount = int( $args[0] );
    my $ways   = making_change($amount);
    say "Output: $ways";
}

sub _run_tests {
    my @cases = (
        { label => 'Example 1',   amount => 9,   expected => 2 },
        { label => 'Example 2',   amount => 15,  expected => 6 },
        { label => 'Example 3',   amount => 100, expected => 292 },
        { label => 'Zero amount', amount => 0,   expected => 1 },
    );

    plan( tests => scalar @cases );
    for my $case (@cases) {
        is( making_change( $case->{amount} ), $case->{expected}, $case->{label} );
    }
    done_testing();
}

_run_cli(@ARGV);

=cut
