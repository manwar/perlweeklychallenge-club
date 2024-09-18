#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 3;

=pod

=head1 DESCRIPTION

This script computes the number of distinct ways to make change for a given amount in cents using US coins.

Coins available:
- Penny (P): 1 cent
- Nickel (N): 5 cents
- Dime (D): 10 cents
- Quarter (Q): 25 cents
- Half-dollar (HD): 50 cents

Order of coin selection does not matter.

=head1 FUNCTIONS

=head2 making_change($amount)

Computes the number of ways to make change for the given amount.

=over 4

=item * C<$amount> - The amount in cents (non-negative integer).

=back

Returns the number of distinct ways to make change.

=cut

sub making_change {
    my ($amount) = @_;
    my @coins = (1, 5, 10, 25, 50);
    my @dp = (0) x ($amount + 1);
    $dp[0] = 1;

    foreach my $coin (@coins) {
        for my $i ($coin .. $amount) {
            $dp[$i] += $dp[$i - $coin];
        }
    }

    return $dp[$amount];
}

# Unit Tests
is(making_change(9),   2,   'Example 1');
is(making_change(15),  6,   'Example 2');
is(making_change(100), 292, 'Example 3');

done_testing();
