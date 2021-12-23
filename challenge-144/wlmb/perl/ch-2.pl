#!/usr/bin/env perl
# Perl weekly challenge 144
# Task 2: Ulam Sequence
#
# See https://wlmb.github.io/2021/12/22/PWC144/#task-2-ulam-sequence
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
say("Usage: ./ch-2.pl u v [N]\nto find the first N (default 10) terms".
    " of the Ulam sequence u,v..."),exit unless @ARGV==2 || @ARGV==3;
say("The given numbers should not be equal"), exit unless $ARGV[0]!=$ARGV[1];
my $ulam=pdl(@ARGV[(0,1)]); # initialize sequence
my $N=$ARGV[2]//10;
foreach(3..$N){
    my $sums=$ulam+$ulam->slice("*"); # addition table for Ulam sequence
    my $ordered=$sums->where(
	($sums->xvals>$sums->yvals)  # upper triangle in addition table
	&($sums>$ulam((-1)) # remove previous terms
	))->qsort; # order
    $ordered=$ordered->where( # eliminate duplicates with right or left
        ($ordered!=$ordered->rotate(-1))
        &($ordered!=$ordered->rotate(1))) if $ordered->nelem>1;
    $ulam=$ulam->append($ordered((0)));
}
say "Input: u=$ARGV[0], v=$ARGV[1]", defined $ARGV[2]?", N=$N":"";
say "Output: $ulam";
