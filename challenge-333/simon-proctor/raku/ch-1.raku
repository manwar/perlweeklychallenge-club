#!/usr/bin/env raku

class Vector2 {
    has Num $.x;
    has Num $.y;
    has Num $.len;

    submethod BUILD(Num() :$x, Num() :$y) {
        $!x = $x;
        $!y = $y;
        $!len = ( ($!x * $!x) + ($!y * $!y)).sqrt;
    }

    method sub(Vector2 $v) { Vector2.new( x => $!x - $v.x, y => $!y - $v.y ) }
    method normal() { $!len > 0 ?? Vector2.new( x => $!x / $!len, y => $!y / $!len ) !! Vector2.new(x=>0,y=>0) }
    method ACCEPTS(Vector2 $v) { $!x =~= $v.x && $!y =~= $v.y }
}

sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is Vector2.new(x => 3, y => 4).len, 5.0;
    ok Vector2.new(x => 1, y => 1).normal.len =~= 1.0;
    ok Vector2.new(x => 1, y => 1.0) ~~ Vector2.new(x => 1.0, y => 1);
    ok is-line([2, 1], [2, 3], [2, 5]);
    ok is-line([1, 4], [3, 4], [10, 4]);
    ok ! is-line([0, 0], [1, 1], [2, 3]);
    ok is-line([1, 1], [1, 1], [1, 1]);
    ok is-line([1000000, 1000000], [2000000, 2000000], [3000000, 3000000]);
    done-testing;
}

sub is-line( **@vecs ) {
    [~~] @vecs.map( -> @p  { Vector2.new(x => @p[0], y => @p[1]) } )
               .rotor(2 => -1)
               .map( -> ($v1, $v2) { $v1.sub($v2).normal } );
                           
}
