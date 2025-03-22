#!/usr/bin/env perl
#
=head1 Task 2: Reverse Letters

Submitted by: Mohammad Sajid Anwar

You are given a string.

Write a script to reverse only the alphabetic characters in the string.

=head2 Example 1

    Input: $str = "p-er?l"
    Output: "l-re?p"

=head2 Example 2

    Input: $str = "wee-k!L-y"
    Output: "yLk-e!e-w"

=head2 Example 3

    Input: $str = "_c-!h_all-en!g_e"
    Output: "_e-!g_nel-la!h_c"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["p-er?l",           "l-re?p",           "Example 1"],
    ["wee-k!L-y",        "yLk-e!e-w",        "Example 2"],
    ["_c-!h_all-en!g_e", "_e-!g_nel-la!h_c", "Example 3"],
];

sub reverse_letters
{
    my $str = shift;

    my @chars = split //, $str;
    my @alphas = grep { $_ =~ /[a-z]/i } @chars;
    my @reversed = reverse @alphas;

    for (my $i = 0; $i < @chars; $i++) {
        if ($chars[$i] =~ /[a-z]/i) {
            $chars[$i] = shift @reversed;
        }
    }
    return join '', @chars;
}

for (@$cases) {
    is(reverse_letters($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
