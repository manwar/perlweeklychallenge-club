#!/usr/bin/env perl
# Perl weekly challenge 143
# Task 1: Stealthy number
#
# See https://wlmb.github.io/2021/12/13/PWC143/#task-2-stealthy-number
use v5.12;
use warnings;
use PDL;
use PDL::NiceSlice;
foreach my $N(@ARGV){
    my $Q=sqrt($N); # largest possible small divisor
    my $s=(sequence($Q)+1);
    my $d=$s->where($N % $s == 0); # list of divisors<=$Q
    my $c=$d->cat($d(*)); # cartesian product of divisors
    my $mask=$d+$N/$d==($d+$N/$d+1)->(*);
    # Get pairs of divisors that obey the stealthy condition
    my $d2=$c->whereND(($d+$N/$d)==($d+$N/$d+1)->(*));
    my $out=$d2->nelem?1:0;
    say "\nInput: $N Output: ", $out;
    say "since ", $_((0)),"+",$N/$_((0)),
        "==",$_((1)),"+",$N/$_((1)),"+1"
        foreach $d2->transpose->dog;
}
