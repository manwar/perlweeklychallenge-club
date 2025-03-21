#!/usr/bin/env perl
#
=head1 Task 1: Broken Keys

Submitted by: Mohammad Sajid Anwar

You have a broken keyboard which sometimes type a character more than once.

You are given a string and actual typed string.

Write a script to find out if the actual typed string is meant for the given
string.

=head2 Example 1

    Input: $name = "perl", $typed = "perrrl"
    Output: true

    Here "r" is pressed 3 times instead of 1 time.

=head2 Example 2

    Input: $name = "raku", $typed = "rrakuuuu"
    Output: true

=head2 Example 3

    Input: $name = "python", $typed = "perl"
    Output: false

=head2 Example 4

    Input: $name = "coffeescript", $typed = "cofffeescccript"
    Output: true

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    [["perl",         "perrrl"],          1, "Example 1"],
    [["raku",         "rrakuuuu"],        1, "Example 2"],
    [["python",       "perl"],            0, "Example 3"],
    [["coffeescript", "cofffeescccript"], 1, "Example 4"],
];

sub broken_keys
{
    my $name  = $_[0]->[0];
    my $typed = $_[0]->[1];

    my @name  = split //, $name;
    my @typed = split //, $typed;

    my $name_idx = 0;
    for my $typed_idx (0 .. $#typed) {
        if (!defined $name[$name_idx] or $name[$name_idx] ne $typed[$typed_idx]) {
            next if $typed_idx > 0 && $typed[$typed_idx] eq $typed[$typed_idx - 1];
            return 0;
        } else {
            $name_idx++;
        }
    }
    return 1;
}

for (@$cases) {
    is(broken_keys($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
