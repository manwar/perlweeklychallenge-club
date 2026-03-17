#!/usr/bin/env perl

# Perl Weekly Challenge 255 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-255/

use Modern::Perl;

my($word, $shuffled) = @ARGV;
for my $ch (split //, $word) {
    $shuffled =~ s/$ch//i;
}
say $shuffled;
