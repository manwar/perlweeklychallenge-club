#!/usr/bin/perl
#
# Challenge 1: "Write a script to find the intersection of two straight
# lines. The co-ordinates of the two lines should be provided as command
# line parameter. For example:
# 
# The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
# 
# The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
# 
# The script should print the co-ordinates of point of intersection of
# the above two lines."
# 
# My notes: Clearly defined, very easy - let's have a go.. and then
# let's run gnuplot to display the results..
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use Function::Parameters;

die "Usage: ch-1.pl line1:a b c d line2:p q r s\n" unless @ARGV == 8;

my ( $a, $b, $c, $d, @rest ) = @ARGV;
my ( $p, $q, $r, $s ) = @rest;

# general form of an infinite line is y = mx + c, and m = (p1y-p2y)/(p1x-p2x)
# (unless p1x==p2x) for any two points p1(x,y) and p2(x,y) on the line, and
# then c = p1y - m*p1x (or p2y - m*p2x)
#
# once we have calculated m1 and c1 for line (a,b)-(c,d), and m2 and c2
# for line (p,q)->(r,s), we need to find the intersection point and check it's
# within the line segments.

say "a=$a, b=$b, c=$c, d=$d, p=$p, q=$q, r=$r, s=$s";

die "line 1: ($a,$b)->($c,$d) is vertical\n" if $b==$d;
my $m1 = ($d-$b)/($c-$a);
my $c1 = $b - $m1 * $a;

die "line 2: ($p,$q)->($r,$s) is vertical\n" if $p==$r;
my $m2 = ($s-$q)/($r-$p);
my $c2 = $q - $m2 * $p;

say "line 1 : y = $m1 x + $c1";
say "line 2 : y = $m2 x + $c2";

# intersection of line 1 and line 2: set line1.y == line2.y:
# (m1-m2) x + (c1-c2) == 0
# (m1-m2) x = c2-c1
# ix = c2-c1/(m1-m2)
# subst in line 1:
# iy = m1 * ix + c1

die "No intersection between $m1 x + $c1 and $m2 x + $c2\n" if $m1==$m2;

my $ix = ($c2-$c1)/($m1-$m2);
my $iy = $m1 * $ix + $c1;
say "intersection at ($ix,$iy)";

print "show results in gnuplot? ";
my $in = <STDIN>;

prepare_gnuplot() if $in =~ /^y/i;


#
# prepare_gnuplot();
#	Prepare the gnuplot files, the data file will contain
#	the two lines, and the command file will continue
#	instuctions to plot both lines and the intersection point
#
fun prepare_gnuplot()
{
	# prepare the data file..
	open( my $outfh, '>', '1.dat' ) || die;
	say $outfh "$a $b $p $q\n$c $d $r $s";
	close( $outfh );

	# prepare the gnuplot command file..
	open( $outfh, '>', '1.cmd' ) || die;
	say $outfh "set grid";
	say $outfh "ix = $ix";
	say $outfh "iy = $iy";
	say $outfh "plot '1.dat' using 1:2 with lines title 'line 1', '1.dat' using 3:4 with lines title 'line 2', '+' using (ix):(iy) title 'intersection'";
	say $outfh "pause mouse key";
	close( $outfh );

	# run gnuplot
	system( "gnuplot 1.cmd" );
}
