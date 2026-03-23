#!/usr/bin/env perl
#
=head1 Task 2: Valid Times

Submitted by: Mohammad Sajid Anwar

You are given a time in the form 'HH:MM'. The earliest possible time is '00:00'
and the latest possible time is '23:59'. In the string time, the digits
represented by the '?' symbol are unknown, and must be replaced with a digit
from 0 to 9.  Write a script to return the count different ways we can make it
a valid time.

=head2 Example 1

    Input: $time = "?2:34"
    Output: 3

    0 -> "02:34" valid
    1 -> "12:34" valid
    2 -> "22:34" valid

=head2 Example 2

    Input: $time = "?4:?0"
    Output: 12

    Hours: tens digit ?, ones digit 4 -> can be 04, and 14 (2 possibilities)
    Minutes: tens digit ?, ones digit 0 -> tens can be 0-5 (6 possibilities)

    Total: 2 x 6 = 12

=head2 Example 3

    Input: $time = "??:??"
    Output: 1440

    Hours: from 00 to 23 -> 24 possibilities
    Minutes: from 00 to 59 -> 60 possibilities

    Total: 24 x 60 = 1440

=head2 Example 4

    Input: $time = "?3:45"
    Output: 3

    If tens digit is 0 or 1 -> any ones digit works, so 03 and 13 are valid
    If tens digit is 2 -> ones digit must be 0-3, but here ones digit is 3, so 23 is valid

    Therefore: 0,1,2 are all valid -> 3 possibilities

=head2 Example 5

    Input: $time = "2?:15"
    Output: 4

    Tens digit is 2, so hours can be 20-23
    Ones digit can be 0,1,2,3 (4 possibilities)

    Therefore: 4 valid times

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["?2:34",    3, 'Example 1'],
    ["?4:?0",   12, 'Example 2'],
    ["??:??", 1440, 'Example 3'],
    ["?3:45",    3, 'Example 4'],
    ["2?:15",    4, 'Example 5'],
];

sub valid_times
{
    my $t = shift;

    $t =~ s/\?/\\d/g;
    my $reg = qr/^$t$/;
    my $cnt = 0;
    for my $h (0 .. 23) {
        for my $m (0 .. 59) {
            $cnt++ if sprintf("%02d:%02d", $h, $m) =~ $reg;
        }
    }

    return $cnt;
}

for (@$cases) {
    is(valid_times($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
