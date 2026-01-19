#!/usr/bin/env perl
#
=head1 Task 1: Digital Clock

Submitted by: Mohammad S Anwar

You are given time in the format hh:mm with one missing digit.  Write a script
to find the highest digit between 0-9 that makes it valid time.

=head2 Example 1

    Input: $time = '?5:00'
    Output: 1

    Since 05:00 and 15:00 are valid time and no other digits can fit in the missing place.

=head2 Example 2

    Input: $time = '?3:00'
    Output: 2

=head2 Example 3

    Input: $time = '1?:00'
    Output: 9

=head2 Example 4

    Input: $time = '2?:00'
    Output: 3

=head2 Example 5

    Input: $time = '12:?5'
    Output: 5

=head2 Example 6

    Input: $time =  '12:5?'
    Output: 9

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ['?5:00', 1, "Example 1"],
    ['?3:00', 2, "Example 2"],
    ['1?:00', 9, "Example 3"],
    ['2?:00', 3, "Example 4"],
    ['12:?5', 5, "Example 5"],
    ['12:5?', 9, "Example 6"],
];

sub digital_clock
{
    my $time = shift;
    my $max_digit = -1;

    for my $digit (0 .. 9) {
        (my $test_time = $time) =~ s/\?/$digit/;
        my ($hh, $mm) = split /:/, $test_time;

        if ($hh =~ /^\d{2}$/ && $mm =~ /^\d{2}$/) {
            if ($hh >= 0 && $hh <= 23 && $mm >= 0 && $mm <= 59) {
                $max_digit = $digit if $digit > $max_digit;
            }
        }
    }

    return $max_digit;
}

for (@$cases) {
    is(digital_clock($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
