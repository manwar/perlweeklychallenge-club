#!/usr/bin/env perl
#
=head1 Task 2: Odd String

Submitted by: Mohammad S Anwar

You are given a list of strings of same length, @s.  Write a script to find the
odd string in the given list. Use positional value of alphabet starting with 0,
i.e. a = 0, b = 1, ... z = 25.  Find the difference array for each string as
shown in the example. Then pick the odd one out.

=head2 Example 1

    Input: @s = ("adc", "wzy", "abc")
    Output: "abc"

    Difference array for "adc" => [ d - a, c - d ]
                               => [ 3 - 0, 2 - 3 ]
                               => [ 3, -1 ]

    Difference array for "wzy" => [ z - w, y - z ]
                               => [ 25 - 22, 24 - 25 ]
                               => [ 3, -1 ]

    Difference array for "abc" => [ b - a, c - b ]
                               => [ 1 - 0, 2 - 1 ]
                               => [ 1, 1 ]

    The difference array for "abc" is the odd one.

=head2 Example 2

    Input: @s = ("aaa", "bob", "ccc", "ddd")
    Output: "bob"

    Difference array for "aaa" => [ a - a, a - a ]
                               => [ 0 - 0, 0 - 0 ]
                               => [ 0, 0 ]

    Difference array for "bob" => [ o - b, b - o ]
                               => [ 14 - 1, 1 - 14 ]
                               => [ 13, -13 ]

    Difference array for "ccc" => [ c - c, c - c ]
                               => [ 2 - 2, 2 - 2 ]
                               => [ 0, 0 ]

    Difference array for "ddd" => [ d - d, d - d ]
                               => [ 3 - 3, 3 - 3 ]
                               => [ 0, 0 ]

    The difference array for "bob" is the odd one.

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    [["adc", "wzy", "abc"],        "abc", "Example 1" ],
    [["aaa", "bob", "ccc", "ddd"], "bob", "Example 2"  ],
];

sub odd_string
{
    my $strings = shift;
    my %diff_map;
    my %string_map;

    for my $str (@$strings) {
        my @chars = split //, $str;
        my @diffs;

        push @diffs, ord($chars[$_]) - ord($chars[$_ - 1]) for 1 .. $#chars;
        my $diff_key = join(',', @diffs);
        push @{$diff_map{$diff_key}}, $str;
        $string_map{$str} = $diff_key;
    }

    for my $key (keys %diff_map) {
        return $diff_map{$key}->[0] if @{$diff_map{$key}} == 1;
    }

    return undef;
}

for (@$cases) {
    is(odd_string($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
