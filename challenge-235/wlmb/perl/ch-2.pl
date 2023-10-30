#!/usr/bin/env perl
# Perl weekly challenge 235
# Task 2:  Duplicate Zeros
#
# See https://wlmb.github.io/2023/09/18/PWC235/#task-2-duplicate-zeros
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to duplicate the zeroes in the array N1, N2...
    without changing the size of the array
    FIN
my @in=@ARGV;
my @out;
while(@in){
    push @out, shift @in; # move from @in to @out
    pop @in,              # remove last element
    push @out, 0          # and duplicate zero
    if @in                # if there is enough space
    && $out[-1]==0;       # and the last element was a 0
}
say "@ARGV -> @out";
