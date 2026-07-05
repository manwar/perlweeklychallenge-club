#!/usr/bin/env perl
#
=head1 Task 1: Sum of Frequencies

Submitted by: Mohammad Sajid Anwar

You are given a string consisting of English letters.  Write a script to find
the vowel and consonant with maximum frequency. Return the sum of two
frequencies.

=head2 Example 1

    Input: $str = "banana"
    Output: 5

    Vowel: "a" appears 3 times.
    Consonant: "n" appears 2 times, "b" appears 1 time.

    Max frequency of vowel: 3
    Max frequency of consonant: 2

=head2 Example 2

    Input: $str = "teestett"
    Output: 7

    Vowel: "e" appears 3 times.
    Consonant: "t" appears 4 times, "s" appears 1 time.

    Max frequency of vowel: 3
    Max frequency of consonant: 4

=head2 Example 3

    Input: $str = "aeiouuaa"
    Output: 3

    Vowel: "a" appears 3 times, "u" 2 times, "e", "i", "o" 1 time each.
    Consonant: None.

    Max frequency of vowel: 3
    Max frequency of consonant: 0

=head2 Example 4

    Input: $str = "rhythm"
    Output: 2

    Vowel: None
    Consonant: "h" appears 2 times, "r", "y", "t", "m" 1 time each.

    Max frequency of vowel: 0
    Max frequency of consonant: 2

=head2 Example 5

    Input: $str = "x"
    Output: 1

    Vowel: None
    Consonant: "x" appears 1 time.

    Max frequency of vowel: 0
    Max frequency of consonant: 1

=cut

use strict;
use warnings;
use v5.42.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => "banana",   out => 5, name => "Example 1"},
    {str => "teestett", out => 7, name => "Example 2"},
    {str => "aeiouuaa", out => 3, name => "Example 3"},
    {str => "rhythm",   out => 2, name => "Example 4"},
    {str => "x",        out => 1, name => "Example 5"},
);

sub sum_of_frequencies
{
    my $str = shift;
    my %vowels = map { $_ => 1 } qw(a e i o u);
    my %freq;
    my $max_vowel_freq = 0;
    my $max_consonant_freq = 0;

    $freq{lc $_}++ for split //, $str;

    for my $char (keys %freq) {
        if ($vowels{$char}) {
            $max_vowel_freq = $freq{$char} if $freq{$char} > $max_vowel_freq;
        } else {
            $max_consonant_freq = $freq{$char} if $freq{$char} > $max_consonant_freq;
        }
    }
    return $max_vowel_freq + $max_consonant_freq;
}

for my $case (@cases) {
    my $got = sum_of_frequencies($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;
