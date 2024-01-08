#!/usr/bin/env raku

multi sub MAIN('test') {
    use Test;
    is smallest-index(0,1,2), 0;
    is smallest-index(4,3,2,1), 2;
    is smallest-index(1,2,3,4,5,6,7,8,9,0), -1;
    done-testing;
}

multi sub MAIN(*@vals) {
    say smallest-index(|@vals);
}

sub smallest-index(*@vals) {
    my $min = @vals.grep( -> $v { $v % 10 ~~ @vals[$v]  } ).min;
    $min = $min ~~ Inf ?? -1 !! $min;
}
