#!/usr/bin/env perl
# Perl weekly challenge 286
# Task 2:  Order Game
#
# See https://wlmb.github.io/2024/09/08/PWC286/#task-2-order-game
use v5.36;
use List::Util qw(min max);
use experimental qw(for_list);
die <<~"FIN" unless @ARGV and ((@ARGV&(@ARGV-1))==0); #finite power of 2
    Usage: $0 N1 N2...Nm
    where m is a power of two to choose min max of consecutive pairs
    and iterate until surviving element is found
    FIN
my @next=@ARGV;
while(@next>2){
    my @minmax;
    for my($p,$q,$r,$s)(@next){
        push @minmax, min($p,$q),max($r,$s);
    }
    @next=@minmax;
}
say "@ARGV -> ",min(@next)
