#!/usr/bin/env perl
# Perl weekly challenge 162
# Task 1: ISBN-13
#
# See https://wlmb.github.io/2022/04/25/PWC162/#task-1-isbn-13
use v5.12;
use warnings;
use List::Util qw(sum);
die "Usage: ./ch-1.pl ISBN1 [ISBN2] ...\n",
    "to calculate the check digit of the ISBN-13 codes ISBNi\n",
    "The first 12 digits should be provided. Extra digits and punctuation are discarded"
    unless @ARGV;
my @factors=(1,3)x6;
foreach(@ARGV){
    my @digits=grep{/\d/}split "", $_; # remove non-digits
    say "ISBN-13 check digit for $_ is ",
        (-(sum map {$factors[$_]*$digits[$_]} 0..11)%10)
}
