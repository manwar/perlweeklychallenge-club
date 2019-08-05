#!/usr/bin/perl
use warnings;
use strict;
use 5.010;

sub LongestCommonSubstring {
    my @strings = sort { length $a <=> length $b } @_;

    my $shortest = shift @strings;
    my @suffixes;
    for my $i (0 .. length($shortest) - 1) {
        for my $j ($i .. length($shortest) - 1) {
            push @suffixes, substr $shortest, $i, $j - $i + 1;
        }
    }
    @suffixes = reverse sort { length $a <=> length $b } @suffixes;

    SUFFIX: for my $suffix (@suffixes) {
        for my $string (@strings) {
            if ( $string !~ /$suffix/) {
                next SUFFIX;
            }
        }
        return $suffix;
    }
}

say LongestCommonSubstring('ABABC', 'BABCA', 'ABCBA');

