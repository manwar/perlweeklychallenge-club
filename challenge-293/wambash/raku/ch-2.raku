#!/usr/bin/env raku

sub slope (+(($x1,$y1), ($x2,$y2))) {
    ($y2-$y1)/($x2-$x1)
}

sub boomerang (+points) {
    points
    andthen .rotor: 2=> -1
    andthen .map: &slope
    andthen [==] $_
    andthen .not
}

multi MAIN (Bool :test($)!) {
    use Test;
    is slope([1,1],[2,1]),0;
    is slope([1,1],[2,2]),1;
    is-deeply slope([1,1],[1,3]),<1/0>;
    is boomerang([1,1],[2,3],[3,2]), True;
    is boomerang([1,1],[2,2],[3,3]), False;
    is boomerang([1,1],[1,2],[2,3]), True;
    is boomerang([1,1],[1,2],[1,3]), False;
    is boomerang([1,1],[2,1],[3,1]), False;
    is boomerang([0,0],[2,3],[4,5]), True;
    is boomerang([1,2],[2,1],[3,0]), False;
    is boomerang([1,2],[2,1],[3,0],[4,-1]), False;
    is boomerang([1,2],[2,1],[3,0],[4,-2]), True;
    is boomerang([2,1],[1,2],[3,0]), False;
    is boomerang([2,1],[3,0],[1,2]), False;
    done-testing;
}

multi MAIN (+points) {
    say boomerang points.map: *.comb(/\-?\d+/).cache
}
