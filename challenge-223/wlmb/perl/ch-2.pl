#!/usr/bin/env perl
# Perl weekly challenge 223
# Task 2:  Box Coins
#
# See https://wlmb.github.io/2023/06/27/PWC223/#task-2-box-coins
use v5.36;
use List::UtilsBy qw(min_by);
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to collect the maximum amount of coins from boxes with N1 N2... coins
    FIN
my @extended=(1,@ARGV,1); # input args with guards on either side
my $total;
my $amount;
$total += $amount while(defined ($amount=next_amount())); # pick coins while they last
say "@ARGV -> $total";

sub next_amount(){ # choose a box and compute coins
    return if @extended==0+2; # no more boxes, the 2 comes from the boundary guards
    return splice @extended,1,1 if @extended==3; # only one box
    my $i=min_by {$extended[$_]} # choose smallest box
        @extended==2+2
	?(1,2)                   # only two remaining boxes, consider boundaries
	:(2..@extended-3);       # more boxes, disregard boundaries
    my $value=splice @extended,$i,1; # remove box from array
    return $value*$extended[$i-1]*$extended[$i]; # compute value from neighbor boxes
}
