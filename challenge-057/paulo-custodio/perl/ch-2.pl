#!/usr/bin/env perl

# Challenge 057
#
# TASK #2 › Shortest Unique Prefix
# Write a script to find the shortest unique prefix for each each word in the
# given list. The prefixes will not necessarily be of the same length.
#
# Sample Input
#     [ "alphabet", "book", "carpet", "cadmium", "cadeau", "alpine" ]
# Expected Output
#     [ "alph", "b", "car", "cadm", "cade", "alpi" ]

use Modern::Perl;

say shortest_prefix(@ARGV);

sub shortest_prefix {
    my(@words) = @_;
    my @prefix;
    for my $word (@words) {
        push @prefix, shortest_prefix1($word, @words);
    }
    return @prefix;
}

sub shortest_prefix1 {
    my($word, @words) = @_;
    for my $i (1 .. length($word)) {
        my $prefix = substr($word, 0, $i);
        my @match = grep {/^$prefix/} @words;
        return $prefix if @match==1;
    }
    return $word;
}
