#!/usr/bin/env perl
# Perl weekly challenge 107
# Task 1: Self-descriptive Numbers
# Brute force solution.
#
# See https://wlmb.github.io/2021/04/05/PWC107/#task-1-self-descriptive-numbers
use strict;
use warnings;
use v5.12;
use List::Util qw(all);
die 'Use: ./ch1a.pl howmany' unless @ARGV;
my $howmany=shift @ARGV;
for my $n(0..10**10-1){ # number of digits <=10
    if(check($n)){
	say $n;
	--$howmany;
	last if $howmany<=0;
    }
}

sub check {
    my $number=shift;
    my @digits=split '',$number;
    my @need=(0)x@digits;
    my @have=(0)x@digits;
    map {$need[$_]=$digits[$_]; $have[$digits[$_]]++} 0..@digits-1;
    return all {$need[$_]==$have[$_]} 0..@digits-1;
}
