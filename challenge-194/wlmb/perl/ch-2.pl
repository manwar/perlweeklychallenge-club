#!/usr/bin/env perl
# Perl weekly challenge 194
# Task 2:  Frequency Equalizer
#
# See https://wlmb.github.io/2022/12/05/PWC194/#task-2-frequency-equalizer
use v5.36;
use PDL;
for(@ARGV){
    my %frequencies;
    $frequencies{$_}++ for(split "");
    my $vals=pdl(my @vals=values %frequencies);
    my $N=@vals;
    my $sum=$vals->sum;
    my $x=($sum-1)/$N;
    my $t=($vals**2)->sum;
    say "$_ -> ", $sum%$N==1 && $t==$N*$x**2 + 2*$x + 1? 1 :0
}
