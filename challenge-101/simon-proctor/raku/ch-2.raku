#!/usr/bin/env raku

use v6;

class Point {...}
class Vector {...}
class Triangle {...}

sub p( *@ (Rat() $x, Rat() $y) ) {
    Point.new( :$x, :$y );
}

sub v( *@ (Point $p1, Point $p2) ) {
    Vector.new( :$p1, :$p2 );
}

sub t( *@ (Point $p1, Point $p2, Point $p3 ) ) {
    Triangle.new( :$p1, :$p2, :$p3 )
}

class Point {
    has Rat() $.x;
    has Rat() $.y;
}

class Vector {
    has Point $.p1;
    has Point $.p2;

    method len() {
	( ($.p1.x - $.p2.x)² + ($.p1.y - $.p2.y)² ).sqrt;
    }
}

class Triangle {
    has Point $.p1;
    has Point $.p2;
    has Point $.p3;

    method area() {
	my \a = v($.p1,$.p2).len;
	my \b = v($.p1,$.p3).len;
	my \c = v($.p2,$.p3).len;
	my \s = (a + b + c) / 2;
	return ( s * (s - a) * (s - b) * (s - c) ).sqrt;
    }

    method point-inside( Point $pn ) {
	my $*TOLERANCE = .0000001;
	return self.area =~=
	( t($pn, $.p1, $.p2).area +
	  t($pn, $.p1, $.p3).area +
	  t($pn, $.p2, $.p3).area );
    }
}

#| Run tests
multi sub MAIN("test") {
    use Test;
    isa-ok( p(2,3), Point, "Point Creation OK" ); 
    isa-ok( v(p(0,0), p(2,2)), Vector, "Vector Creation OK" );
    isa-ok( t(p(0,0), p(0,3), p(4,0)), Triangle, "Triangle Creation OK" );
    is( v(p(0,0), p(3,4)).len, 5, "Vector Length works" );
    is( t(p(0,0), p(0,3), p(4,0)).area, 6, "Triangle Area works" );
    is( t(p(0,1),p(1,0),p(2,2)).point-inside(p(0,0)), False, "Origin not in Triangle" );
    is(	t(p(1,1),p(-1,1),p(0,-3)).point-inside(p(0,0)), True, "Origin in Triangle" );
    is(	t(p(0,1),p(2,0),p(-6,0)).point-inside(p(0,0)), True, "Origin on edge test" );
}

#| Does the triangle made from the 6 gives points contain the origin?
multi sub MAIN( Rat() $p1x, Rat() $p1y,
		Rat() $p2x, Rat() $p2y,
		Rat() $p3x, Rat() $p3y ) {
    say t(p($p1x,$p1y),
	  p($p2x,$p2y),
	  p($p3x,$p3y)).point-inside(p(0,0)) ?? 1 !! 0;   
}
