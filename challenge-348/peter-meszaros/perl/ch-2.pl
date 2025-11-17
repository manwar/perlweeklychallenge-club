#!/usr/bin/env perl
#
=head1 Task 2: Convert Time

Submitted by: Mohammad Sajid Anwar

You are given two strings, $source and $target, containing time in 24-hour time
form.

Write a script to convert the source into target by performing one of the
following operations:

    1. Add  1 minute
    2. Add  5 minutes
    3. Add 15 minutes
    4. Add 60 minutes

Find the total operations needed to get to the target.

=head2 Example 1

    Input: $source = "02:30"
           $target = "02:45"
    Output: 1

    Just one operation i.e. "Add 15 minutes".

=head2 Example 2

    Input: $source = "11:55"
           $target = "12:15"
    Output: 2

    Two operations i.e. "Add 15 minutes" followed by "Add 5 minutes".

=head2 Example 3

    Input: $source = "09:00"
           $target = "13:00"
    Output: 4

    Four operations of "Add 60 minutes".

=head2 Example 4

    Input: $source = "23:45"
           $target = "00:30"
    Output: 3

    Three operations of "Add 15 minutes".

=head2 Example 5

    Input: $source = "14:20"
           $target = "15:25"
    Output: 2

    Two operations, one "Add 60 minutes" and one "Add 5 minutes"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["02:30", "02:45"], 1, "Example 1"],
    [["11:55", "12:15"], 2, "Example 2"],
    [["09:00", "13:00"], 4, "Example 3"],
    [["23:45", "00:30"], 3, "Example 4"],
    [["14:20", "15:25"], 2, "Example 5"],
];

sub convert_time
{
    my $source = $_[0]->[0];
    my $target = $_[0]->[1];

    my ($sh, $sm) = split(':', $source);
    my ($th, $tm) = split(':', $target);
    my $source_mins = $sh * 60 + $sm;
    my $target_mins = $th * 60 + $tm;
    $target_mins += 24 * 60 if $target_mins < $source_mins;
    my $diff = $target_mins - $source_mins;
    my $ops = 0;
    for my $add (60, 15, 5, 1) {
        while ($diff >= $add) {
            $diff -= $add;
            $ops++;
        }
    }
    return $ops;
}

for (@$cases) {
    is(convert_time($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
