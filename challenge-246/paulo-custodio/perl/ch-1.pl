#!/usr/bin/env perl

# Perl Weekly Challenge 246 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-246/

use Modern::Perl;

use constant NR_BALLS => 49;
use constant NR_DRAWS => 6;

if (@ARGV) {
    srand($ARGV[0]+0);
}

my @balls = (1..NR_BALLS);
my @drawn;
for (1..NR_DRAWS) {
    my $i = int(rand()*scalar(@balls));
    push @drawn, splice(@balls, $i, 1);
}

say join("\n", sort {$a<=>$b} @drawn);
