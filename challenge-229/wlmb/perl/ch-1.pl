#!/usr/bin/env perl
# Perl weekly challenge 229
# Task 1:  Lexicographic Order
#
# See https://wlmb.github.io/2023/08/06/PWC229/#task-1-lexicographic-order
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV;
    Usage: $0 s1 [s2...]
    to count how many strings s1 s2... are not lexicographically sorted.
    Assume loer or upper case ASCII inputs.
    FIN
my $count=0;
for(@ARGV){
    my $z=(
	my $y=(
            my $x=pdl([map {ord} split "", lc]) # convert to lower case and to numbers
	    )->(-1:0)                           # reverse order
	)->qsort;                               # increasing sort

    ++$count
	if ($x!=$z)->any                        # string changes upon sorting
           &&($y!=$z)->any                      # reversed string changes upon sorting
}
say "@ARGV->", $count;
