#!/usr/bin/perl -w

use strict;
use warnings;
use feature qw(say);
use DDP;

=head2

TASK #1 › Group Anagrams
Submitted by: Mohammad S Anwar
You are given an array of strings @S.

Write a script to group Anagrams together in any random order.

An Anagram is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

Example 1:
    Input: ("opt", "bat", "saw", "tab", "pot", "top", "was")
    Output: [ ("bat", "tab"),
              ("saw", "was"),
              ("top", "pot", "opt") ]
Example 2:
    Input: ("x")
    Output: [ ("x") ]

=cut

my @S = ("opt", "bat", "saw", "tab", "pot", "top", "was");

my %output;
my @output;

for my $str(@S)
{
  my $anagram;
  $anagram .= $_ for (sort split //, $str );
  push @{$output{$anagram}}, $str;
}

@output = values %output;

p @output;

=head2
perl ch-1.pl
[
    [0] [
        [0] "opt",
        [1] "pot",
        [2] "top"
    ],
    [1] [
        [0] "bat",
        [1] "tab"
    ],
    [2] [
        [0] "saw",
        [1] "was"
    ]
]
=cut