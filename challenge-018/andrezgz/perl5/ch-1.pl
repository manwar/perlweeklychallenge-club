#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-018/
# Task #1
# Write a script that takes 2 or more strings as command line parameters
# and print the longest common substring.
# For example, the longest common substring of the strings
# "ABABC", "BABCA" and "ABCBA" is string "ABC" of length 3.
# Other common substrings are "A", "AB", "B", "BA", "BC" and "C".
# Please check this wiki page for details.
# https://en.wikipedia.org/wiki/Longest_common_substring_problem

use strict;
use warnings;
use English qw(-no_match_vars);

die "Usage: $PROGRAM_NAME string1 string2 [stringN]" if (@ARGV < 2);

my @strings = map {uc $_ }                    # case-insensitive comparing
              sort {length $a <=> length $b}  # shortest first
              @ARGV;

# get all of the substrings from the shortest string
my @shortest_subs = get_all_substr(shift @strings);

my $l = 0;
my @longest;

SUB: foreach my $sub (@shortest_subs) {

    # stop if the length of this substring is shorter than the previous one
    # and matches were found
    last if (length $sub < $l && @longest);
    $l = length $sub;

    # check if any of the other strings does not contain this substring
    foreach my $str (@strings) {
        next SUB if (index($str,$sub) == -1);
    }

    # the substring is common to all
    push @longest, $sub;
}

print 'Longest common substring(s): '.join(',',@longest)."\n";

# return all substrings for a certain string ordered by longest first
sub get_all_substr {
    my $s = shift;
    my $l = length $s;
    my @subs;

    for ( my $from = 0; $from < $l; $from++ ) {
        for ( my $to = 1; $to < $l - $from + 1; $to++) {
            push @subs, substr $s, $from, $to;
        }
    }

    my @subs_sorted = reverse sort {length $a <=> length $b} @subs;
    return @subs_sorted;
}
