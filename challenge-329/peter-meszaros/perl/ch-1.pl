#!/usr/bin/env perl
#
=head1 Task 1: Counter Integers

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and digits.

Write a script to replace every non-digit character with a space and then
return all the distinct integers left.

=head2 Example 1

    Input: $str = "the1weekly2challenge2"
    Output: 1, 2

    2 is appeared twice, so we count it one only.

=head2 Example 2

    Input: $str = "go21od1lu5c7k"
    Output: 21, 1, 5, 7

=head2 Example 3

    Input: $str = "4p3e2r1l"
    Output: 4, 3, 2, 1

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["the1weekly2challenge2", [1, 2],        "Example 1"],
    ["go21od1lu5c7k",         [21, 1, 5, 7], "Example 2"],
    ["4p3e2r1l",              [4, 3, 2, 1],  "Example 3"],
];

sub counter_integers
{
    my $str = shift;

    my %seen;
    my @numbers = grep {/[0-9]/} split /[^0-9]+/, $str;
    my @counter_integers;
    foreach my $num (@numbers) {
        push @counter_integers, $num unless $seen{$num};
        $seen{$num} = 1;
    }
    return \@counter_integers;
}

for (@$cases) {
    is(counter_integers($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
