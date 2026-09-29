#!/usr/bin/env perl
#
=head1 Task 1: Pythagoras Multiplied

Submitted by: Ulrich Rieke

You are given a positive integer n.  Find the number of all positive integer
triplets (a, b, c) so that a^2 + b^2 = c^2 and a, b and c are integers <= n.

=head2 Example 1

    Input: $n = 20
    Output: 12

    (3,4,5),  (4,3,5),   (5,12,13),(6,8,10),
    (8,6,10), (8,15,17), (9,12,15),(12,5,13),
    (12,9,15),(12,16,20),(15,8,17),(16,12,20)

=head2 Example 2

    Input: $n = 7
    Output: 2

    (3,4,5),(4,3,5)

=head2 Example 3

    Input: $n = 1
    Output: 0

=head2 Example 4

    Input: $n = 15
    Output: 8

=head2 Example 5

    Input: $n = 30
    Output: 22

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {n => 20, out => 12, name => 'Example 1'},
    {n =>  7, out =>  2, name => 'Example 2'},
    {n =>  1, out =>  0, name => 'Example 3'},
    {n => 15, out =>  8, name => 'Example 4'},
    {n => 30, out => 22, name => 'Example 5'},
);

sub pythagoras_multiplied
{
    my $n = shift;

    my $count = 0;
    for my $a (1 .. $n) {
        for my $b (1 .. $n) {
            my $c = sqrt($a**2 + $b**2);
            $count++ if $c == int($c) && $c <= $n;
        }
    }
    return $count;
}

for my $case (@cases) {
    my $got = pythagoras_multiplied($case->{n});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
