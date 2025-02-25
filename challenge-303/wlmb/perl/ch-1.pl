#!/usr/bin/env perl
# Perl weekly challenge 303
# Task 1:  3-digits Even
#
# See https://wlmb.github.io/2025/01/06/PWC303/#task-1-3-digits-even
use v5.36;
use Algorithm::Combinatorics qw(tuples);
use List::Util qw(uniq);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 N2...
    to build all uniq three digit even numbers from the digits of the number Ni
    FIN
for(@ARGV){
    die "Expected three or more digits: $_" unless $_=~/^\d{3,}$/;
    my @digits=sort {$a <=> $b} split "";
    my @result=uniq map {join "",@$_} grep {$_->[0]&&!($_->[2]%2)} tuples(\@digits,3);
    say "$_ -> @result";
}
