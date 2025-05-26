#!/usr/bin/env perl
#
=head1 Task 1: Increment Decrement

Submitted by: Mohammad Sajid Anwar

You are given a list of operations.

Write a script to return the final value after performing the given operations
in order. The initial value is always 0.

Possible Operations:

    ++x or x++: increment by 1
    --x or x--: decrement by 1

=head2 Example 1

    Input: @operations = ("--x", "x++", "x++")
    Output: 1

    Operation "--x" =>  0 - 1 => -1
    Operation "x++" => -1 + 1 =>  0
    Operation "x++" =>  0 + 1 =>  1

=head2 Example 2

    Input: @operations = ("x++", "++x", "x++")
    Output: 3

=head2 Example 3

    Input: @operations = ("x++", "++x", "--x", "x--")
    Output: 0

    Operation "x++" => 0 + 1 => 1
    Operation "++x" => 1 + 1 => 2
    Operation "--x" => 2 - 1 => 1
    Operation "x--" => 1 - 1 => 0

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["--x", "x++", "x++"],        1, "Example 1"],
    [["x++", "++x", "x++"],        3, "Example 2"],
    [["x++", "++x", "--x", "x--"], 0, "Example 3"],
    [["x++", , "--y", "x--"],  undef, "Example 4"],
];

sub increment_decrement
{
    my $operations = shift;
    my $value = 0;
    for my $op (@$operations) {
        if ($op eq '++x' || $op eq 'x++') {
            $value++;
        } elsif ($op eq '--x' || $op eq 'x--') {
            $value--;
        } else {
            return undef;
        }
    }
    return $value;
}

for (@$cases) {
    is(increment_decrement($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
