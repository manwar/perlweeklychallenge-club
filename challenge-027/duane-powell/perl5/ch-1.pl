#!/usr/bin/perl
use Modern::Perl;
use List::Util qw[min max];

# Write a script to find the intersection of two straight lines. The co-ordinates of the two lines should be provided as command line parameter 

usage() unless @ARGV == 8;
my ($a,$b,$c,$d,$p,$q,$r,$s) = @ARGV;
my ($x1,$y1,$z1,$x2,$y2,$z2);

$x1 = $a-$c;
$y1 = $d-$b;
$z1 = ($x1 * $b) + ($y1 * $a);
$x2 = $p-$r;
$y2 = $s-$q;
$z2 = ($x2 * $q) + ($y2 * $p);
my $determinant =  ($x2*$y1) - ($x1*$y2);

if ($determinant == 0) {
	say "Line segments ($a,$b)($c,$d) and ($p,$q)($r,$s) are parallel";
	exit;
}
my $x = ($x2 * $z1 - $x1 * $z2)/$determinant;
my $y = ($y1 * $z2 - $y2 * $z1)/$determinant;
my $intersect = ($x >= min($a,$c)) && ($x <= max($p,$r)) && ($y >= min($b,$d)) && ($y <= max($q,$s));

if ($intersect) {
	say "Intersection of line segments ($a,$b)($c,$d) and ($p,$q)($r,$s) is ($x,$y)";
} else {	
	say "Line segments ($a,$b)($c,$d) and ($p,$q)($r,$s) do not intersect";
	say "Extended segment would intersect at ($x,$y)";
}
exit;

sub usage {
        print <<EOU;
Usage:
$0 a b c d  p q r s

Calculate two line segments intersection point (x,y)
Give 2 line segment end-points as a list of 8 numbers 

Examples
$0 -5 0 5 0     0 5 0 -5     # intersects at (0,0)
$0 -5 6 5 6     0 5 0 -5     # does not intersect 
$0 -5 6 5 6    -5 0 5  0     # parallel
EOU
        exit;
}

__END__

./ch-1.pl -5 0 5 0     0 5 0 -5
Intersection of line segments (-5,0)(5,0) and (0,5)(0,-5) is (0,0)

./ch-1.pl -5 6 5 6     0 5 0 -5
Line segments (-5,6)(5,6) and (0,5)(0,-5) do not intersect
Extended segment would intersect at (0,6)

./ch-1.pl -5 6 5 6    -5 0 5  0
Line segments (-5,6)(5,6) and (-5,0)(5,0) are parallel

