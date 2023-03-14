#!/usr/bin/env perl
# Perl weekly challenge 207
# Task 2:  H-Index
#
# See https://wlmb.github.io/2023/03/06/PWC207/#task-2-h-index
use v5.36;
my $h=0;
for(sort{$b<=>$a}@ARGV){
    last if $_<=$h;
    ++$h
}
say join " ", @ARGV, "->", $h;
