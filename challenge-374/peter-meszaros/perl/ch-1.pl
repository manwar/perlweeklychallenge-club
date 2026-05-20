#!/usr/bin/env perl
#
=head1 Task 1: Count Vowel

Submitted by: Mohammad Sajid Anwar

You are given a string. Write a script to return all possible vowel substrings
in the given string. A vowel substring is a substring that only consists of
vowels and has all five vowels present in it.

=head2 Example 1

    Input: $str = "aeiou"
    Output: ("aeiou")

=head2 Example 2

    Input: $str = "aaeeeiioouu"
    Output: ("aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu")

    NOTE: Updated output [2025-05-18]

=head2 Example 3

    Input: $str = "aeiouuaxaeiou"
    Output: ("aeiou", "aeiou", "eiouua", "aeiouu", "aeiouua")

    NOTE: Updated output [2025-05-18]

=head2 Example 4

    Input: $str = "uaeiou"
    Output: ("aeiou", "uaeio", "uaeiou")

=head2 Example 5

    Input: $str = "aeioaeioa"
    Output: ()

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["aeiou",         ["aeiou"],                                                "Example 1"],
    ["aaeeeiioouu",   ["aaeeeiioou", "aaeeeiioouu", "aeeeiioou", "aeeeiioouu"], "Example 2"],
    ["aeiouuaxaeiou", ["aeiou", "aeiouu", "aeiouua", "eiouua", "aeiou"],        "Example 3"],
    ["uaeiou",        ["uaeio", "uaeiou", "aeiou"],                             "Example 4"],
    ["aeioaeioa",     [],                                                       "Example 5"],
];

sub count_vowel {
    my $str = shift;
    my @results;

    for my $i (0 .. length($str) - 1) {
        my %seen;
        my $substr = "";

        for my $j ($i .. length($str) - 1) {
            my $char = substr($str, $j, 1);

            last unless $char =~ /[aeiou]/;

            $substr .= $char;
            $seen{$char} = 1;

            push @results, $substr if keys %seen == 5;
        }
    }

    return \@results;
}

for (@$cases) {
    is(count_vowel($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;




