#!/usr/bin/env perl
#
=head1 Task 1: Replace all ?

Submitted by: Mohammad Sajid Anwar

You are given a string containing only lower case English letters and ?.

Write a script to replace all ? in the given string so that the string doesn't
contain consecutive repeating characters.

=head2 Example 1

    Input: $str = "a?z"
    Output: "abz"

    There can be many strings, one of them is "abz".
    The choices are 'a' to 'z' but we can't use either 'a' or 'z' to replace
    the '?'.

=head2 Example 2

    Input: $str = "pe?k"
    Output: "peak"

=head2 Example 3

    Input: $str = "gra?te"
    Output: "grabte"

=cut

use strict;
use warnings;
use Test2::V0 -no_srand => 1;
use Data::Dumper;

my $cases = [
    ["a?z",    "abz",    "Example 1"],
    ["pe?k",   "peak",   "Example 2"],
    ["gra?te", "grabte", "Example 3"],
];

sub replace_all_questionmark {
    my $str = shift;
    my @chars = split //, $str;
    my $len = @chars;

    for (my $i = 0; $i < $len; $i++) {
        if ($chars[$i] eq '?') {
            my %used;
            $used{$chars[$i - 1]} = 1 if $i > 0 && $chars[$i - 1] ne '?';
            $used{$chars[$i + 1]} = 1 if $i < $len - 1 && $chars[$i + 1] ne '?';

            for my $c ('a' .. 'z') {
                if (!$used{$c}) {
                    $chars[$i] = $c;
                    last;
                }
            }
        }
    }

    return join '', @chars;
}

for (@$cases) {
    is(replace_all_questionmark($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
