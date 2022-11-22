#!/usr/bin/env perl
# Perl weekly challenge 192
# Task 2:  Equal Distribution
#
# See https://wlmb.github.io/2022/11/21/PWC192/#task-2-equal-distribution
use v5.36;
use List::Util qw(sum reduce all);
die <<"EOF" unless @ARGV;
Usage: $0 N1 [N2..]
to count how many one-unit neighbor transfers are required to distribute the values
in the integer array N1 N2... equally.
EOF
die "Only integers allowed" unless all {/[+-]?\d+/} @ARGV;
my @current=@ARGV;
my $result=0;
if((sum @current)%@current){
    $result=-1
} else {
    ++$result while transfer()
}
say join " ", @ARGV, "->", $result;
sub transfer{ # transfers one unit to reduce largest difference. Returns +-1 on success 0 on failure
    return 0 if @current<=1; # nothing to do
    my @diff=map {$current[$_+1]-$current[$_]} 0..@current-2;
    my $index=reduce {abs($diff[$a])<abs($diff[$b])?$b:$a} 0..@diff-1; # Find max diff
    my $sign=$diff[$index]>0?-1:$diff[$index]<0?1:0; # direction of transfer: left(-1) or right(+1))
    @current[$index,$index+1] = map {$sign=-$sign; $_+$sign} @current[$index, $index+1]; #update
    return $sign;
}
