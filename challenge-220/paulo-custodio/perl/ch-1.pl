#!/usr/bin/env perl

# Perl Weekly Challenge 220 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-220/

use Modern::Perl;

my @words = @ARGV;
my @letters;
my %chars;
for (0..$#words) {
    for my $ch (split //, lc($words[$_])) {
        $letters[$_]{$ch} = 1;
        $chars{$ch} = 1;
    }
}

my @result;

for my $ch (sort keys %chars) {
    my $count = 0;
    for (0..$#words) {
        $count++ if $letters[$_]{$ch};
    }
    push @result, $ch if $count == @words;
}

say "@result";
