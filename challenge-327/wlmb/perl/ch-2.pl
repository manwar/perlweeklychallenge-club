#!/usr/bin/env perl
# Perl weekly challenge 327
# Task 2:  MAD
#
# See https://wlmb.github.io/2025/06/26/PWC327/#task-2-mad
use v5.36;
die <<~"FIN" unless @ARGV>=2;
    Usage: $0 N1 N2...
    to find the pair of integers Ni Nj separated by
    the minimum absolute difference.
    FIN
my $minimum=abs($ARGV[1]-$ARGV[0]);
my @result;
for my $i(0..@ARGV-1){
    my $x=$ARGV[$i];
    for my $j($i+1..@ARGV-1){
	my $y=$ARGV[$j];
	my $distance=abs($x-$y);
	$minimum=$distance, @result=() if $distance < $minimum;
	push @result, $x<$y? [$x,$y]:[$y,$x] if $distance==$minimum;
    }
}
say "[@ARGV] -> [", (map{"[@$_]"} @result),"]"
