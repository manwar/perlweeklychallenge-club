#!/usr/bin/env perl
#
=head1 Task 1: No Connection

Submitted by: Mohammad Sajid Anwar

You are given a list of routes, @routes.

Write a script to find the destination with no further outgoing connection.

=head2 Example 1

    Input: @routes = (["B","C"], ["D","B"], ["C","A"])
    Output: "A"

    "D" -> "B" -> "C" -> "A".
    "B" -> "C" -> "A".
    "C" -> "A".
    "A".

=head2 Example 2

    Input: @routes = (["A","Z"])
    Output: "Z"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [[["B", "C"], ["D","B"], ["C","A"]], "A", 'Example 1'],
    [[["A", "Z"]                      ], "Z", 'Example 2'],
];

sub no_connection
{
    my $branches = shift;

    my (%s, @e);
    for my $br (@$branches) {
        push @e, $br->[0];
        $s{$br->[1]} = 1;
    }
    delete @s{@e};
    return (keys %s)[0];
}

for (@$cases) {
    is(no_connection($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
