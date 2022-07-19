#!/usr/bin/env perl
# Perl weekly challenge 174
# Task 1: Disarium numbers
#
# See https://wlmb.github.io/2022/07/18/PWC174/#task-1-disarium-numbers
use v5.12;
use PDL;
say("Usage: $0 N\nto obtain the first N Disarium numbers"), exit unless @ARGV;
my $how_many=shift;
die "Expected a positive number" unless $how_many>0;
my ($counter, $test)=(0, 0);
while($counter<$how_many){
    my $exponents=(my $digits=long [split "", $test])->sequence+1;
    ++$counter, say "$counter: $test"
        if ($digits**$exponents)->sumover==$test;
    ++$test
}
