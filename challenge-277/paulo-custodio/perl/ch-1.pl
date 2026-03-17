#!/usr/bin/env perl

# Perl Weekly Challenge 277 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-277/

use Modern::Perl;

my $words = "@ARGV";
my @words = split /,/, $words;

my $count = [];
for my $i (0..1) {
    for my $word (split ' ', $words[$i]) {
        $count->[$i]{$word}++;
    }
}

my $count_same = 0;
for my $word (split ' ', @words[0..1]) {
    $count_same++ if ($count->[0]{$word}//0)==1 && ($count->[1]{$word}//0)==1;
}

say $count_same;
