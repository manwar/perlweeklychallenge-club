#!/usr/bin/env perl

# Perl Weekly Challenge 166 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-166/

use Modern::Perl;

@ARGV==1 or die "usage: ch-1.pl words.txt\n";
while (<>) {
    chomp;
    if (/^[a-folist]{2,8}$/i) {
        my $word=$_;
        $word=~tr/olist/01157/;
        say "0x".uc($word);
    }
}
