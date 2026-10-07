#!/usr/bin/env perl
#
=head1 Task 2: Alternating Vowels Consonants

Submitted by: Mohammad Sajid Anwar

You are given three strings containing English alphabetic characters.  Find all
the longest contiguous substrings common to all three strings that strictly
alternate between vowels and consonants.

=head2 Example 1

    Input: @str = ("relocate", "delocate", "allocate")
    Output: ("locate")

=head2 Example 2

    Input: @str = ("apple", "banana", "cherry")
    Output: ()

=head2 Example 3

    Input: @str = ("navigate", "cavity", "gravity")
    Output: ("avi")

=head2 Example 4

    Input: @str = ("pedalgia", "pedalboard", "pedantic")
    Output: ("peda")

=head2 Example 5

    Input: @strings = ("schoolmaster", "schoolhouse", "schooling")
    Output: ("ho", "ol")

=cut

use strict;
use warnings;
use v5.44.0;
use Test2::V0 -no_srand => 1;
use Data::Dumper;
use constant { true => 1, false => 0 };

my @cases = (
    {str => ["relocate",     "delocate",    "allocate"], out =>["locate"],    name => 'Example 1'},
    {str => ["apple",        "banana",      "cherry"],   out =>[],            name => 'Example 2'},
    {str => ["navigate",     "cavity",      "gravity"],  out =>["avi"],       name => 'Example 3'},
    {str => ["pedalgia",     "pedalboard",  "pedantic"], out =>["peda"],      name => 'Example 4'},
    {str => ["schoolmaster", "schoolhouse", "schooling"], out =>["ho", "ol"], name => 'Example 5'},
);

sub is_vowel {
    my ($c) = @_;
    return $c =~ /[aeiouAEIOU]/;
}

sub alternating_substrings {
    my $s = shift;

    my %result;
    my @chars = split //, $s;
    my $n = @chars;

    for my $i (0 .. $n - 1) {
        my $sub = $chars[$i];
        $result{$sub} = 1;

        for my $j ($i + 1 .. $n - 1) {
            last if is_vowel($chars[$j]) == is_vowel($chars[$j - 1]);
            $sub .= $chars[$j];
            $result{$sub} = 1;
        }
    }

    return \%result;
}

sub alternating_vowels_consonants
{
    my $str = shift;

    my $as1 = alternating_substrings($str->[0]);
    my $as2 = alternating_substrings($str->[1]);
    my $as3 = alternating_substrings($str->[2]);

    my %common;

    for my $s (keys %$as1) {
        $common{$s} = 1 if exists $as2->{$s} && exists $as3->{$s};
    }

    my $max_len = 0;
    for my $s (keys %common) {
        my $len = length($s);
        $max_len = $len if $len > $max_len;
    }

    my @answer = sort grep { length($_) == $max_len } keys %common;

    return \@answer;
}

for my $case (@cases) {
    my $got = alternating_vowels_consonants($case->{str});
    is($got, $case->{out}, $case->{name});
}
done_testing();

exit 0;

