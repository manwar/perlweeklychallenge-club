#!/usr/bin/env perl
# Perl weekly challenge 333
# Task 1:  Straight Line
#
# See https://wlmb.github.io/2025/08/04/PWC333/#task-1-straight-line
use v5.36;
use experimental qw(try);
use PDL;
use PDL::NiceSlice;

die <<~"FIN" unless @ARGV;
    Usage: $0 A1 A2...
    to test if the arrays An of 2D points lie on a straight line.
    An are strings of the form "[[x1 y1][x2 y2]...[xn yn]]"
    FIN
my $result;
for(@ARGV){
    try {
        my $points = pdl($_);
        die "Expected an array of 2D vectors: $_"
	    unless $points->ndims==2 and $points->dim(0)==2;
	$result=1, next if $points->dim(1)<=2; # two or less points lie on a straight line
	my $differences= ($points(:,1:-1)-$points(:,0));    # subtract first point from all others
        # Throw away points that duplicate the first
	my $vectors = $differences->mv(1,0)->whereND($differences->magnover!=0)->mv(0,1);
	$result=1, next if $vectors->dim(1)==0; # one vector is in a straight line
	# make matrices with the first vector and each of the others.
	# The indices are the cartesian index, the row index and the number of matrix
	my $matrices=pdl($vectors(:,0), $vectors(:,1:-1))->mv(-1,1);
	my $dets = $matrices->det; # array of determinants
	$result=($dets==0)->all, next;
    }
    catch($e){
	say $e;
    }
}
continue {
    say "$_ -> ", $result?"True":"False";
}
