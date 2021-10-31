#!/usr/bin/env perl
# Perl weekly challenge 136
# Task 1: Two friendly
#
# See https://wlmb.github.io/2021/10/25/PWC136/#task-1-two-friendly
use v5.12;
while(defined(my $x=shift @ARGV) and defined(my $y=shift @ARGV)){
    my $d=gcd($x, $y);
    my $b=sprintf "%b", $d;
    my $output=$b=~/^1(0+)$/||0;
    my $power=length($1);
    say "Inputs: $x, $y\nOutput: $output\nSince gcd($x,$y)=$d",
        $power?"=2**$power":"";
}
sub gcd {
    my ($x,$y)=@_;
    $y==0?$x:gcd($y,$x%$y);
}
