#!/usr/bin/env perl
# Perl weekly challenge 251
# Task 2:  Lucky Numbers
#
# See https://wlmb.github.io/2024/01/08/PWC251/#task-2-lucky-numbers
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 A1 [A2...]
    to find lucky numbers in the arrays A1, A2...
    The format of the arrays should be "[[a00 a01...],[a10 a11...],...]",
    to be read by pdl.
    FIN
while(@ARGV){
    my $in=pdl(shift);
    my $min=$in->minover->dummy(0);
    my $max=$in->mv(1,0)->maxover->dummy(1);
    my $result=$in->where(($in==$min)&($in==$max));
    say "$in -> ", $result->isempty?-1:$result;
}
