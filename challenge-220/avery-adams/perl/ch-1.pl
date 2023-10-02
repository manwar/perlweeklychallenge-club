#!/usr/bin/perl

use strict;
use v5.24;

my @results;
my $first_word = shift;
for my $letter (split(//, $first_word)) {
    push(@results, lc($letter)) if (grep {$_ =~ /$letter/i} @ARGV) == @ARGV;
}
@results = sort @results;
say $_ foreach @results;
