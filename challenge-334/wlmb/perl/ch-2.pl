#!/usr/bin/env perl
# Perl weekly challenge 334
# Task 2:  Nearest Valid Point
#
# See https://wlmb.github.io/2025/08/11/PWC334/#task-2-nearest-valid-point
use v5.36;
use feature qw(try);
use PDL;
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 F1 P1 F2 P2...
    to find the index in the array of points Pi of the valid
    point nearest to Fi. Fi is input as the string "[x y]" and
    Pi as the string "[[x1 y1][x2 y2]...]"
    FIN
for my ($first_str, $points_str)(@ARGV){
    try{
	my ($first, $points)=map{pdl $_}($first_str, $points_str);
	my $indices=whichND(orover($points==$first));
	my $valid=$points->mv(-1,0)->indexND($indices)->mv(0,-1);
	my $manhattan=($valid-$first)->abs->sumover;
	my $result=-1;
	if($manhattan->nelem){
	    my $min=$manhattan->min;
	    my $close=which($manhattan==$min);
	    $result=$indices->flat->index($close)->min;
	}
	say "given=$first, points=$points -> $result";
    }
    catch($e){
	say $e;
    }
}
