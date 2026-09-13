#!/usr/bin/env perl
#
=head1 Task 2: Secret Santa

Submitted by: Roger Bell_West

A company with $n employees is running a Secret Santa exchange. Each employee
buys one gift and receives one gift.  Write a script to return the total number
of valid gift assignments where no employee receives the gift they originally
bought (i.e., employee $i must not be assigned gift $i).

=head2 Example 1

    Input: $n = 1
    Output: 0

    Only 1 participant exists. They would have to receive their own gift, which
    is invalid.

=head2 Example 2

    Input: $n = 2
    Output: 1

    Participants 1 and 2 must swap gifts ([2, 1]).

=head2 Example 3

    Input: $n = 3
    Output: 2

    The 2 valid gift arrays where array[i] is who person i+1 receives from:
    [2, 3, 1]
    [3, 1, 2]

=head2 Example 4

    Input: $n = 4
    Output: 9

    The 9 valid arrays are:
    [2, 1, 4, 3], [2, 3, 4, 1], [2, 4, 1, 3],
    [3, 1, 4, 2], [3, 4, 1, 2], [3, 4, 2, 1],
    [4, 1, 2, 3], [4, 3, 1, 2], [4, 3, 2, 1],

=head2 Example 5

    Input: $n = 5
    Output: 44

    There are 44 valid permutations out of 5! = 120 total possible arrangements.

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {n => 1, out =>  0, name => 'Example 1'},
    {n => 2, out =>  1, name => 'Example 2'},
    {n => 3, out =>  2, name => 'Example 3'},
    {n => 4, out =>  9, name => 'Example 4'},
    {n => 5, out => 44, name => 'Example 5'},
);

sub secret_santa
{
    my $n = shift;

    my @dp = (0) x ($n + 1);
    $dp[0] = 1;
    $dp[1] = 0;
    for my $i (2 .. $n) {
        $dp[$i] = ($i - 1) * ($dp[$i - 1] + $dp[$i - 2]);
    }
    return $dp[$n];
}

for my $case (@cases) {
    my $got = secret_santa($case->{n});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
