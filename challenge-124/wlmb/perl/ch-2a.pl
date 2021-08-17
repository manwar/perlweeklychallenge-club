#!/usr/bin/env perl
# Perl weekly challenge 124
# Task 2: Tug of war. Simulated Annealing
#
# See https://wlmb.github.io/2021/08/02/PWC124/#task-2-tug-of-war
use strict;
use warnings;
use v5.12;
use POSIX qw(floor);
use List::Util qw(sum0);

die 'Usage: ./ch-2a.pl steps low n1 n2 n3... to balance a set of numbers n1...' unless @ARGV>=2;
my ($steps, $low_frac, @set)=@ARGV; # length of sim, low to high T ratio, values.
@set=sort {$a <=> $b} @set;
my $N=@set; # number of elements
my $k=floor $N/2;
my $high=$set[-1]-$set[0]; # Max difference
my $T=$high; # starting temperature
my $low=$low_frac*$high; # ending temperature
my $factor=$low_frac**(1/$steps);
#srand(0); #seed, for tests only
my @set1=@set[0..$k-1]; # starting sets
my @set2=@set[$k..$N-1];
my ($sum1, $sum2)=map {sum0 @$_} \@set1, \@set2;
my $E=abs($sum2-$sum1); # energy
while($T>$low){
    my ($i1, $i2)=(rand($k),rand($N-$k)); # random indices to swap
    my ($new_sum1, $new_sum2)=($sum1-$set1[$i1]+$set2[$i2],$sum2+$set1[$i1]-$set2[$i2]);
    my $newE=abs($new_sum2-$new_sum1);
    my $dE=$newE-$E;
    if($dE<=0 || rand(1)<exp(-$dE/$T)){ # Exchange elements
	($set1[$i1],$set2[$i2])=($set2[$i2],$set1[$i1]);
	($sum1,$sum2)=($new_sum1, $new_sum2);
	$E=$newE;
    }
    $T*=$factor;
}
say "T High: $high, T Low: $low, Steps: $steps";
say "Input: ", join " ", @set;
say "Set1: ", join " ", sort {$a<=>$b} @set1;
say "Set2: ", join " ", sort {$a<=>$b} @set2;
say "Diff: ", $E;
