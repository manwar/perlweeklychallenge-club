#!/usr/bin/env perl
# Perl weekly challenge 198
# Task 1:  Max Gap
#
# See https://wlmb.github.io/2023/01/02/PWC198/#task-1-max-gap
use v5.36;
my @sorted=sort {$a<=>$b} @ARGV;
my %count;
my $max;
for(1..@sorted-1){
    ++$count{my $gap=$sorted[$_]-$sorted[$_-1]};
    $max=$gap if !defined $max || $gap>$max;
};
say join " ", @ARGV, "->", $count{$max}||0
