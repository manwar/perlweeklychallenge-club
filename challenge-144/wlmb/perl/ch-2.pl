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
my $ulam=pdl[$ARGV[0]]; # initialize sequence
my $candidates=pdl[$ARGV[1]]; # candidate list
my $N=$ARGV[2]//10;
foreach(2..$N){
    my $sl=$candidates->qsort; # short list
    # remove duplicates
    $sl=$sl->where(($sl!=$sl->rotate(1))&($sl!=$sl->rotate(-1))) if $sl->nelem>1;
    my $next=$sl->((0)); # Next Ulam number
    $candidates=$candidates->append($ulam+$next); # Update candidate list
    $candidates=$candidates->where($candidates>$next); # remove those too small
    $ulam=$ulam->append([$next]); # update list of ulam numbers
}
say "Input: u=$ARGV[0], v=$ARGV[1]", defined $ARGV[2]?", N=$N":"";
say "Output: $ulam";
