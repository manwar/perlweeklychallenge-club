#!/usr/bin/env perl
# Perl weekly challenge 192
# Task 2:  Equal Distribution. Simpler version
#
# See https://wlmb.github.io/2022/11/21/PWC192/#task-2-equal-distribution
use v5.36;
use List::Util qw(sum all);
die <<"EOF" unless @ARGV;
Usage: $0 N1 [N2..]
to count how many one-unit neighbor transfers are required to distribute the values
in the integer array N1 N2... equally.
EOF
die "Only integers allowed" unless all {/[+-]?\d+/} @ARGV;
my @arr=@ARGV;
my $result=0;
if((sum @arr)%@arr){
    $result=-1
} else {
    $result=0;
    my $avg=sum(@arr)/@arr;
    for(1..@arr){
	my $extra=$arr[$_-1]-$avg;
	$arr[$_]+=$extra; # $arr[$_-1]-=$extra;
	$result+=abs $extra;
    }
}
say join " ", @ARGV, "->", $result;
