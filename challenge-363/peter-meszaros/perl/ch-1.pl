#!/usr/bin/env perl
#
=head1 Task 1: String Lie Detector

Submitted by: Mohammad Sajid Anwar

You are given a string.  Write a script that parses a self-referential string
and determines whether its claims about itself are true. The string will make
statements about its own composition, specifically the number of vowels and
consonants it contains.

=head2 Example 1

    Input: $str = "aa - two vowels and zero consonants"
    Output: true

=head2 Example 2

    Input: $str = "iv - one vowel and one consonant"
    Output: true

=head2 Example 3

    Input: $str = "hello - three vowels and two consonants"
    Output: false

=head2 Example 4

    Input: $str = "aeiou - five vowels and zero consonants"
    Output: true

=head2 Example 5

    Input: $str = "aei - three vowels and zero consonants"
    Output: true

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my $cases = [
    ["aa - two vowels and zero consonants",      true, "Example 1"],
    ["iv - one vowel and one consonant",         true, "Example 2"],
    ["hello - three vowels and two consonants", false, "Example 3"],
    ["aeiou - five vowels and zero consonants",  true, "Example 4"],
    ["aei - three vowels and zero consonants",   true, "Example 5"],
];

sub string_lie_detector
{
    my $str = shift;
    my ($s, $v, $c) = $str =~ /^(.*) - (\w+) vowels? and (\w+) consonants?$/;
    return undef unless defined $s && defined $v && defined $c;

    my %numbers = (zero  => 0,
                   one   => 1,
                   two   => 2,
                   three => 3,
                   four  => 4,
                   five  => 5,
                   six   => 6,
                   seven => 7,
                   eight => 8,
                   nine  => 9,
               );
                   
    return undef unless exists $numbers{$v} && exists $numbers{$c};

    my ($vowels, $consonants) = (0, 0);
    for (split //, $s) {
        if (/[aeiou]/i) {
            $vowels++;
        } elsif (/[a-z]/i) {
            $consonants++;
        }
    }

    return $vowels == $numbers{$v} && $consonants == $numbers{$c};
}

for (@$cases) {
    is(string_lie_detector($_->[0]), $_->[1], $_->[2]);
}
done_testing();

exit 0;
