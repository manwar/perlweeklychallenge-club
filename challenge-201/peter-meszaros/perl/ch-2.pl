#!/usr/bin/env perl
#
=head1 Task 2: Penny Piles

Submitted by: Robbie Hatley

You are given an integer, $n > 0.

Write a script to determine the number of ways of putting $n pennies in a row
of piles of ascending heights from left to right.

=head2 Example

    Input: $n = 5
    Output: 7

    Since $n=5, there are 7 ways of stacking 5 pennies in ascending piles:

        1 1 1 1 1
        1 1 1 2
        1 2 2
        1 1 3
        2 3
        1 4
        5

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use Algorithm::Combinatorics qw/partitions/;
use Digest::SHA qw/sha512_hex/;

my $cases = [
    [5, 7],
];

sub penny_piles
{
    my $n = shift;

    my @data = (1) x $n;
    my %h;
    my $iter = partitions(\@data);
    while (my $p = $iter->next) {
        my @p = sort {$a <=> $b} map { scalar @$_ } @$p;
        ++$h{sha512_hex(join('-', @p))};
    }

    return scalar keys %h;
}

for (@$cases) {
    is(penny_piles($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
