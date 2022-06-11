#!/usr/bin/env perl
# Perl weekly challenge 160
# Task 2: Equilibrium index
#
# See https://wlmb.github.io/2022/04/11/PWC160/#task-2-equilibrium-index
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
die "Usage: ./ch-2.pl N1 [N2...] to find equilibrium index of an array of numbers"
    unless @ARGV;
my $input=pdl(@ARGV);
my $result="-1 as no equilibrium index was found"; # default output
say "Input: ", $input;
for(1..$input->nelem-2){ #for all internal indices
   $result="$_ as sum(".$input(0:$_-1).")==sum(".$input($_+1:-1).")", last
   if $input(0:$_-1)->sumover==$input($_+1:-1)->sumover; # Found equilibrium
}
say "Output: $result";
