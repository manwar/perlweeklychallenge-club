#!/usr/bin/env perl
# Perl weekly challenge 327
# Task 2:  MAD
#
# PDL version
# See https://wlmb.github.io/2025/06/26/PWC327/#task-2-mad
use v5.36;
use PDL;
use PDL::NiceSlice;
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 A1 A2...
    to find distinct pairs of integers [Ni Nj] taken from the array
    Ap=[N1 N2...] separated by the minimum absolute difference.
    The input should be in the form of strings "[N1 N2...]" which may
    be interpreted as ndarrays by PDL.
    FIN
for(@ARGV){
    my $p=pdl($_);                                                  # 1D array
    say("Expected a 1D array: $_"), next unless $p->ndims==1;
    my $n=$p->nelem;
    say("Expected two or more elements: $_"), next unless $n>1;
    my $pp=$p->dummy(0,$n);                                         # 2D array
    my $ad=($pp-$p)->abs;                                           # abs difference
    my $min=$ad->where($ad>0)->min;                                 # MAD
    my $pairs=pdl($pp,$pp->mv(0,1))->whereND($ad==$min);            # select pairs
    say "$p -> ",$pairs->whereND($pairs(:,0)<$pairs(:,1))->mv(0,1); # output distinct
}
