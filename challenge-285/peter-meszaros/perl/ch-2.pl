#!/usr/bin/env perl
#
=head1 Task 2: Making Change

Submitted by: David Ferrone

Compute the number of ways to make change for given amount in cents. By using
the coins e.g. Penny, Nickel, Dime, Quarter and Half-dollar, in how many
distinct ways can the total value equal to the given amount? Order of coin
selection does not matter.

    A penny (P) is equal to 1 cent.
    A nickel (N) is equal to 5 cents.
    A dime (D) is equal to 10 cents.
    A quarter (Q) is equal to 25 cents.
    A half-dollar (HD) is equal to 50 cents.

=head2 Example 1

    Input: $amount = 9
    Ouput: 2

    1: 9P
    2: N + 4P

=head2 Example 2

    Input: $amount = 15
    Ouput: 6

    1: D + 5P
    2: D + N
    3: 3N
    4: 2N + 5P
    5: N + 10P
    6: 15P

=head2 Example 3

    Input: $amount = 100
    Ouput: 292

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [  9,   2, 'Example 1'],
    [ 15,   6, 'Example 2'],
    [100, 292, 'Example 3'],
];

# https://tech.tonyballantyne.com/2019/03/04/coin-change-problem/
#             HD   Q   D  N  P
my $values = [50, 25, 10, 5, 1];

sub coin
{
    my ($n, $val) = @_;

    return 1 if $values->[$val] == 1;

    my $total = 0;
    while ($n >= $values->[$val]) {
        $total += coin($n, $val+1);
        $n -= $values->[$val];
    }
    return $total + coin($n, $val+1);
}

sub making_change
{
    my $sum = shift;
    return coin($sum, 0);
}

for (@$cases) {
    is(making_change($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
