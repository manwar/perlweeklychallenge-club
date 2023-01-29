#!/usr/bin/env perl
# Perl weekly challenge 201
# Task 2:  Penny Piles
#
# See https://wlmb.github.io/2023/01/23/PWC201/#task-2-penny-piles
use v5.36;
use List::Util qw(min sum);
use Memoize;
memoize "rows";
die <<~"FIN" unless @ARGV;
    Usage: $0 N1 [N2...]
    to obtain the number of ascending rows of piles of Ni coins.
    FIN
say "$_->", rows($_, $_) for @ARGV;
sub rows($coins,$max){
    return 1 if $coins==0;
    return sum map{rows($coins-$_,min($_, $coins-$_))} 1..min($coins, $max)
}
