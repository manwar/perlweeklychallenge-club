#!/usr/bin/perl6
use v6;

use Test;

# 27.1 Write a script to find the intersection of two straight lines. The co-ordinates of the two lines should be provided as command line parameter. For example:
#
# The two ends of Line 1 are represented as co-ordinates (a,b) and (c,d).
#
# The two ends of Line 2 are represented as co-ordinates (p,q) and (r,s).
#
# The script should print the co-ordinates of point of intersection of the above two lines.

#| Prints intersection point of two lines given as 1,2,3,4   5,6,7,8
multi MAIN(Str $line1,Str $line2) {
    my ($meet,$x,$y,$comment) = intersection(| $line1.split(','), | $line2.split(','));
    say $meet ?? "$x,$y" !! $comment;
    exit;
}

sub intersection($a,$b,$c,$d,$e,$f,$g,$h) {
    # line 1 a,b -> c,d
    # line 2 e,f -> g,h

    my $m1=($b-$d)/($a-$c);
    my $m2=($f-$h)/($e-$g);

    return (False,Nil,Nil,"Do not intersect: lines are parallel") if $m1==$m2;

    # y=dydx1.x-dydx1.a+b == y=dydx2.x-dydx2.e+f

    # x=dydx1.a-b/dydx1
    # wrong worong worng my $x=($m1*$a-$b)/$m1;

    my $x=($f-$b+$m1*$a-$m2*$e)/($m1-$m2);

    my $y=$m2*$x-$m2*$e+$f;

    return (False,Nil,Nil,"Do not intersect: x is not on line 1") if $x < $a < $c or $x > $c > $a;
    return (False,Nil,Nil,"Do not intersect: y is not on line 1") if $y < $b < $d or $y > $d > $b;
    return (False,Nil,Nil,"Do not intersect: x is not on line 2") if $x < $e < $g or $x > $g > $e;
    return (False,Nil,Nil,"Do not intersect: y is not on line 2") if $y < $f < $h or $y > $h > $f;

    return (True,$x,$y,"Lines intersect at $x,$y");

}

multi MAIN('test') {
    my ($meet,$x,$y,$comment) = intersection(1,1,3,3, 1,3,3,1);
    is $meet,True,"Test A - lines meet";
    is $x,2,"Test A - lines meet - x";
    is $y,2,"Test A - lines meet - y";
    diag $comment;
    ($meet,$x,$y,$comment) = intersection(1,1,3,3, 1,2,3,4);
    is $meet,False,"Test A - lines meet";
    diag $comment;
    ($meet,$x,$y,$comment) = intersection(1,1,3,3, 4,3,6,1);
    is $meet,False,"Test A - lines meet";
    diag $comment;
    ($meet,$x,$y,$comment) = intersection(1,1,3,3, 1,1,3,3);
    is $meet,False,"Test D - lines are parallel";


    done-testing;
}
