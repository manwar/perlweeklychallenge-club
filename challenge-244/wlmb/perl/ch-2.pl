#!/usr/bin/env perl
# Perl weekly challenge 244
# Task 2:  Group Hero
#
# See https://wlmb.github.io/2023/11/20/PWC244/#task-2-group-hero
use v5.36;
use Algorithm::Combinatorics qw(subsets);
use List::Util qw(min max);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to obtain the sum of the /powers/ of all combinations of all sizes
    of elements of the list N1 N2..
    FIN
my $subsets=subsets(\@ARGV);
my $total=0;
while(my $subset=$subsets->next){
    $total+= max(@$subset)**2*min(@$subset) if @$subset
}
say "@ARGV -> $total";
