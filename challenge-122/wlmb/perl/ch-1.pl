#!/usr/bin/env perl
# Perl weekly challenge 122
# Task 1: Average of stream
#
# See https://wlmb.github.io/2021/07/19/PWC122/#task-1-average-of-stream
use strict;
use warnings;
use v5.12;
my $counter=0; # item counter
my $total=0; # running total
while(<>){
    chomp;
    ++$counter;
    $total += $_;
    my $average=$total/$counter;
    say "Input: $_ Output: $average";
}
