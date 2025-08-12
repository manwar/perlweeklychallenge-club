#!/usr/bin/env perl
# Perl weekly challenge 334
# Task 1:  Range Sum
#
# See https://wlmb.github.io/2025/08/11/PWC334/#task-1-range-sum
use v5.36;
use PDL;
use feature qw(try);
die <<~"FIN" unless @ARGV and @ARGV%3==0;
    Usage: $0 I1 X1 Y1 I2 X2 Y2...
    to sum elements Xi to Yi of the array Ii.
    Ii is a string in the format "[i0 i1 i2...]"
    where the i's are numbers.
    FIN
for my ($s, $x, $y)(@ARGV){
     try{
        my $i=pdl($s);
	my $n=$i->nelem;
	die "Expected 0<=X<=Y<$n: x=$x, y=$y"
	   unless 0<=$x<=$y<$n;
	say "x=$x, y=$y, ints=$s -> ", $i->slice([$x,$y])->sumover;
     }
     catch($e){
	 say $e;
     }
}
