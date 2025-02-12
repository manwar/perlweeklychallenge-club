#!/usr/bin/env perl
# Perl weekly challenge 307
# Task 2:  Find Anagrams
#
# See https://wlmb.github.io/2025/02/02/PWC307/#task-2-find-anagrams
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 W0 W1 W2
    to count anagram equivalence classes among the words Wi.
    FIN
my $last;
my $count=0;
(!defined $last || $_ ne $last)&&++$count, $last = $_
    for map {
        my %hash;
        $hash{lc $_}++ for split "";
        join "", map {
            $_, $hash{$_}
        }sort keys %hash
    } @ARGV;
say "@ARGV -> $count";
