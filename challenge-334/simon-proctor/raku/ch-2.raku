#!/usr/bin/env raku

sub MAIN(:t(:$test)) is hidden-from-USAGE {
    use Test;
    is closest-point-in-line( x => 3, y => 4, [1, 2], [3, 1], [2, 4], [2, 3]), 2;
    is closest-point-in-line( x => 2, y => 5, [3, 4], [2, 3], [1, 5], [2, 5]), 3;
    is closest-point-in-line( x => 1, y => 1, [2, 2], [3, 3], [4, 4]), -1;
    is closest-point-in-line( x => 0, y => 0, [0, 1], [1, 0], [0, 2], [2, 0]), 0;
    is closest-point-in-line( x => 5, y => 5, [5, 6], [6, 5], [5, 4], [4, 5]), 0;
    done-testing;
}

sub closest-point-in-line( Int :$x, Int :$y, **@points ) {
    my @indexed = @points
                   .map( { $++ => $_ } )
                   .grep( -> $p { $p.value[0] ~~ $x || $p.value[1] ~~ $y } )
                   .map( -> $p { $p.key => manhattan( $x, $y, |$p.value ) } )
                   .sort( { $^a.value <=> $^b.value } )
                   .map(*.key);
    @indexed ?? @indexed[0] !! -1;
}

sub manhattan($x1, $y1, $x2, $y2) { abs($x1-$x2) + abs($y1-$y2) } 
