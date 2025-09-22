#!/usr/bin/env perl
# Perl weekly challenge 340
# Task 2:  Ascending Numbers
#
# See https://wlmb.github.io/2025/09/22/PWC340/#task-2-ascending-numbers
use v5.36;
use List::Util qw(uniq);
for(@ARGV){
    my @splitted= grep {length>0} split/[^0-9]+/;  # split on non digits. May let some badly formed strings through
    my @sorted = sort {$a<=>$b} uniq @splitted; # remove duplicates and numerically sort all numbers
    my $result = "@sorted" eq "@splitted"?"True":"False"; # join and compare as strings
    say "$_ -> ", $result
}
