#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-014/
# Challenge #1
# Write a script to generate Van Eck's sequence starts with 0.
# For more information, please check out wikipedia page.
# This challenge was proposed by team member Andrezgz.
# https://en.wikipedia.org/wiki/Van_Eck%27s_sequence

use strict;
use warnings;

my $upto = $ARGV[0] || 50;

my $n_1 = 0;    #sequence start
my %last;       #last position for each number

print $n_1;
for my $pos (1 .. $upto-1) {

    my $n = exists $last{$n_1} ? $pos - $last{$n_1} : 0;
    print ', '.$n;

    $last{$n_1} = $pos;
    $n_1 = $n;
}
