#!/usr/bin/env perl
# Perl weekly challenge 194
# Task 2:  Frequency Equalizer. Without PDL
#
# See https://wlmb.github.io/2022/12/05/PWC194/#task-2-frequency-equalizer
use v5.36;
use List::Util qw(sum);
for(@ARGV){
    my %frequencies;
    $frequencies{$_}++ for(split "");
    my @vals=values %frequencies;
    my $N=@vals;
    my $sum=sum @vals;
    my $x=($sum-1)/$N;
    my $t=sum map {$_*$_} @vals;
    say "$_ -> ", $sum%$N==1 && $t==$N*$x**2 + 2*$x + 1? 1 :0
}
