#!/usr/bin/env perl
# Perl weekly challenge 271
# Task 1:  Maximum Ones
#
# See https://wlmb.github.io/2024/05/28/PWC271/#task-1-maximum-ones
use v5.36;
use PDL;
die <<~"FIN" unless @ARGV;
    Usage: $0 [[m11 m12...][m21 m22...]...]
    to find the row with the largest number of 1 entries,
    or the first largest row in case of a tie.
    Rows are numbered from 1 upwards.
    FIN
for(@ARGV){
    my $in=pdl($_);
    my @ones=($in==1)->sumover->dog; # ones in each row
    my @sorted=sort {$ones[$b] <=> $ones[$a] || $a<=>$b} 0..@ones-1;
    say "$in -> ",1+$sorted[0];
}
