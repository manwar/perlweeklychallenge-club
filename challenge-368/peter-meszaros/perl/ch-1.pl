#!/usr/bin/env perl
#
=head1 Task 1: Make it Bigger

Submitted by: Mohammad Sajid Anwar

You are given a given a string number and a character digit.  Write a script to
remove exactly one occurrence of the given character digit from the given
string number, resulting the decimal form is maximised.

=head2 Example 1

    Input: $str = "15456", $char = "5"
    Output: "1546"

    Removing the second "5" is better because the digit following it (6) is
    greater than 5. In the first case, 5 was followed by 4 (a decrease),
    which makes the resulting number smaller.

=head2 Example 2

    Input: $str = "7332", $char = "3"
    Output: "732"

=head2 Example 3

    Input: $str = "2231", $char = "2"
    Output: "231"

    Removing either "2" results in the same string here. By removing a "2",
    we allow the "3" to move up into a higher decimal place.

=head2 Example 4

    Input: $str = "543251", $char = "5"
    Output: "54321"

    If we remove the first "5", the number starts with 4. If we remove the
    second "5", the number still starts with 5. Keeping the largest possible
    digit in the highest place value is almost always the priority.

=head2 Example 5

    Input: $str = "1921", $char = "1"
    Output: "921"

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [[ "15456", "5"],  "1546", "Example 1"],
    [[  "7332", "3"],   "732", "Example 2"],
    [[  "2231", "2"],   "231", "Example 3"],
    [["543251", "5"], "54321", "Example 4"],
    [[  "1921", "1"],   "921", "Example 5"],
];

sub make_it_bigger
{
    my $str = $_[0]->[0];
    my $char =  $_[0]->[1];

    my @chars = split //, $str;
    my $pos = -1;

    for (my $i = 0; $i < @chars; $i++) {
        if ($chars[$i] eq $char) {
            $pos = $i;
            unless ($i == @chars - 1 || $chars[$i + 1] le $char) {
                $pos = $i;
                last;
            }
        }
    }
    return join('', @chars[0 .. $pos - 1], @chars[$pos + 1 .. $#chars]);
}

for (@$cases) {
    is(make_it_bigger($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
