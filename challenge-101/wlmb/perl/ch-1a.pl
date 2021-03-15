#!/usr/bin/env perl
# Perl weekly challenge 101
# Task 1: Pack a spiral PDL solution
#
# See https://wlmb.github.io/2021/02/22/PWC101/#task-1-pack-a-spiral
use strict;
use warnings;
use v5.12;
use List::Util qw(first);
use PDL;
use PDL::NiceSlice;

sub usage {
    say "./ch-1.pl item1 item2...\nArranges items in spiral";
    exit 1;
}
my $total=@ARGV;
my $M=first {@ARGV%$_==0} reverse(1..sqrt @ARGV); #Highest divisor below sqrt
my $N=@ARGV/$M; #smallest divisor above sqrt

my $m=zeroes($M, $N);
spiral($m,0);
say "Input: ", join " ", @ARGV;
say "Output:";
for my $r(reverse 0..$N-1){
    print $ARGV[$m->at($_, $r)], "\t" for (0..$M-1);
    say "";
}

sub spiral { # receive a pdl to storee result and the starting value
    my ($m, $start)=@_;
    $m(,(0)).=sequence($m->dim(0))+$start;
    return $m if $m->dim(1)==1;
    spiral($m->transpose->(1:-1,-1:0), $start+$m->dim(0));
}
