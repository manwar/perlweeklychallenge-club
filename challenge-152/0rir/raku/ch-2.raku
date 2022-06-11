#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab
use v6.d;
use Test;

# Rectangle Area  #152

constant \TEST = False;

class Point {
    has Int $.x;
    has Int $.y;
    method Str ( --> Str) {  "($!x,$!y)" }
}

class Rect {
    has Point $.a;
    has Point $.b;

    submethod TWEAK {
        die 'Got a dot or a linear; or points are out of order '
            ~ "$!a.x(), $!a.y(),  $!b.x(), $!b.y()"
                unless $!a.x < $!b.x and $!a.y < $!b.y;
    }
    method Str( --> Str) { "$!a.Str(), $!b.Str()" }

    method area( --> Int ) { ($!b.x - $!a.x) × ($!b.y - $!a.y) }
}
my &Pt = &point;

#   Test against 10, 10, 20, 20
#       rect                 area   total
my @test =
    # misses
    [ rect(  9,  9, 10, 10 ),   1, 101 ],
    [ rect(  9, 20, 10, 21 ),   1, 101 ],
    [ rect( 20, 20, 21, 21 ),   1, 101 ],
    [ rect( 20,  9, 21, 10 ),   1, 101 ],
    # contains
    [ rect( 10, 10, 20, 20 ), 100, 100 ], # eqv
    [ rect(  9,  9, 21, 21 ), 144, 144 ],
    [ rect( 10, 10, 20, 21 ), 110, 110 ],
    [ rect( 10, 10, 21, 20 ), 110, 110 ],
    [ rect(  9, 10, 20, 20 ), 110, 110 ],
    [ rect( 10,  9, 20, 20 ), 110, 110 ],
    [ rect( 10,  0, 20, 30 ), 300, 300 ],
    [ rect(  0, 10, 30, 20 ), 300, 300 ],
    # contained
    [ rect( 10, 10, 20, 20 ), 100, 100 ], # eqv
    [ rect( 11, 11, 19, 19 ),  64, 100 ],
    [ rect( 10, 10, 11, 11 ),   1, 100 ],
    [ rect( 19, 19, 20, 20 ),   1, 100 ],
    [ rect( 10, 19, 11, 20 ),   1, 100 ],
    # overlaps
    [ rect(  7,  7, 12, 12 ),  25, 121 ],  # w
    [ rect(  7, 18, 12, 23 ),  25, 121 ],  # w
    [ rect( 18, 18, 23, 23 ),  25, 121 ],  # e
    [ rect( 18,  7, 23, 12 ),  25, 121 ],  # e
    [ rect( 12,  7, 13, 25 ),  18, 108 ],  # vert
    [ rect( 10,  5, 11, 25 ),  20, 110 ],  # vert
    [ rect( 11,  5, 12, 25 ),  20, 110 ],  # vert
    [ rect( 13, 16, 15, 25 ),  18, 110 ],  # head
    [ rect( 13,  5, 15, 13 ),  16, 110 ],  # tail
    [ rect( 19,  5, 20, 15 ),  10, 105 ],  # tail
    [ rect(  5, 10, 25, 12 ),  40, 120 ],  # hori
    [ rect(  5, 13, 25, 14 ),  20, 110 ],  # hori
    [ rect( 15, 17, 25, 18 ),  10, 105 ],  # hori
    #fences
    [ rect(  9,  9, 21, 10 ),  12, 112 ],  # miss
    [ rect(  9,  9, 10, 21 ),  12, 112 ],  # miss
    [ rect(  9, 20, 21, 21 ),  12, 112 ],  # miss
    [ rect( 20,  9, 21, 21 ),  12, 112 ],  # miss
    [ rect( 10, 18, 21, 20 ),  22, 102 ],  # hori
    [ rect(  9, 18, 21, 20 ),  24, 104 ],  # hori
    [ rect(  9, 18, 20, 20 ),  22, 102 ],  # hori
    [ rect( 10, 10, 21, 12 ),  22, 102 ],  # hori
    [ rect(  9, 10, 21, 12 ),  24, 104 ],  # hori
    [ rect(  9, 10, 20, 12 ),  22, 102 ],  # hori
    [ rect( 10,  9, 12, 20 ),  22, 102 ],  # vert
    [ rect( 10,  9, 12, 21 ),  24, 104 ],  # vert
    [ rect( 10, 10, 12, 22 ),  24, 104 ],  # vert
    [ rect( 18, 10, 20, 21 ),  22, 102 ],  # vert
    [ rect( 18,  9, 20, 21 ),  24, 104 ],  # vert
    [ rect( 18,  9, 20, 21 ),  24, 104 ],  # vert
;

my $l = (@test.pick)[0];
my $r = (@test.pick)[0];

say
"Input: Rectangle 1 => $l.Str()
       Rectangle 2 => $r.Str()

Output: ", coverage( $l, $r);

exit unless TEST;

sub point( Int $x, Int $y ) { Point.Mu::new( :x($x), :y($y)); }

sub area( Point $j, Point $k --> Int ) {
    abs( ($j.x - $k.x) × ( $j.y -$k.y) )
}

sub rect( Int $ax, Int $ay, Int $bx, Int $by) {
    Rect.Mu::new( :a(Pt($ax, $ay)), :b(Pt($bx, $by)));
}

sub infix:< misses > ( Rect $l, Rect $r --> Int ) {
    if      $l.a.y ≥ $r.b.y or $l.a.x ≥ $r.b.x
        or  $l.b.y ≤ $r.a.y or $l.b.x ≤  $r.a.x
    {
                return $l.area + $r.area;
   }
   0
};

sub infix:< contains > ( Rect $l, Rect $r --> Int ) {
    if      $l.a.x ≤ $r.a.x and $l.a.y ≤ $r.a.y
        and $r.b.y ≤ $l.b.y and $r.b.x ≤ $l.b.x
    {
                return  $l.area;
    }
    0
}

sub _west-ish ( Rect $l, Rect $r --> Int ) {
    if      $l.a.x < $r.a.x
        and $r.a.x < $l.b.x < $r.b.x
    {
        if $l.a.y ≤ $r.a.y and $r.b.y ≤ $l.b.y {    #little:BIG
            return $l.area + $r.area - area( $r.a, Pt($l.b.x, $r.b.y));
        }
        if $l.a.y ≥ $r.a.y and $r.b.y ≥ $l.b.y {    #BIG:little
            return $l.area + $r.area - area( Pt($r.a.x,$l.a.y), $l.b);
        }
        if $l.a.y ≥ $r.a.y and $r.b.y ≤ $l.b.y {    # upper:lower
            return $l.area + $r.area
                - area( Pt($r.a.x, $l.a.y), Pt($l.b.x, $r.b.y ));
        }
        if $l.a.y ≤ $r.a.y and $l.b.y ≤ $r.b.y {    # lower:upper
            return $l.area + $r.area - area( $r.a, $l.b);
        }
        die 'Not reached';
    }
    0
}

sub _east-ish ( Rect $l, Rect $r --> Int ) { _west-ish( $r, $l) }

sub _horizontal-cross ( Rect $l, Rect $r --> Int ) {
    if      $r.a.y ≤ $l.a.y and $l.b.y ≤ $r.b.y
        and $l.a.x ≤ $r.a.x and $r.b.x ≤ $l.b.x
    {
        return $l.area + $r.area
            - ( area( Pt($r.a.x, $l.a.y), Pt( $r.b.x, $l.b.y) ) )
    }
    0
}

sub _vertical-cross( Rect $l, Rect $r --> Int ) {
    if $r.a.x ≤ $l.a.x and $l.b.x ≤ $r.b.x {
        if $r.b.y < $l.b.y  and $l.a.y < $r.a.y {
            return $l.area + $r.area
                - area( Pt($l.a.x, $r.b.y),Pt( $l.b.x, $r.a.y));
        }
        if $r.b.y < $l.b.y {
            return $l.area + $r.area - area( $l.a, Pt( $l.b.x, $r.b.y));
        }
        if $l.a.y < $r.a.y {
            return $l.area + $r.area - area( Pt( $l.a.x, $r.a.y), $l.b);
        }
    }
    0
}

sub coverage( Rect $l, Rect $r --> Int ) {
    for (
        ($l misses $r),
        ($l contains $r),
        ($r contains $l),
        _west-ish( $l, $r),
        _east-ish( $l, $r),
        _vertical-cross( $l, $r),
        _horizontal-cross( $l, $r),
       ) -> $a
    {
       return $a if $a ≠ 0;
   }
   die 'I goofed:  Cannot happen' ;
}

plan 8 + 2 × @test;

my $p = point( 2, 5);
is $p.Str,  '(2,5)', 'point and point.Str';
my $q = point( -7,-4);
is area( $p, $q), 81, "Pt to Pt area $p $q";
is area( $q, $p), 81, "Pt to Pt area $q $p";
dies-ok { rect( 10,10,20,0) }, 'rect is downhill';
dies-ok { rect( 10,10,10,10) }, 'rect is dot';
dies-ok { rect( 10,10,10,20) }, 'rect is vertical line';
dies-ok { rect( 10,10,20,10) }, 'rect is horizontal line';

my $ref = rect( 10, 10, 20, 20 );
is $ref.area, 100, '$ref.area';

for @test -> @t {
    is @t[0].area, @t[1], "area of @t[0].Str()";
    is coverage( @t[0], $ref), @t[2],  "coverage";
}
done-testing;
