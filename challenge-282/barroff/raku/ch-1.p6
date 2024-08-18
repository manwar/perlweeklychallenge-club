#!/usr/bin/env raku

use v6.d;

sub good-integer(Int $int where $int > 99) {
    $int ~~ /
        [
            (\d)? {} :my $c=$0; <!before $c>
            (\d) $1 $1 {}
            :my $d=$1; <!before $d>]
        |
        [
            ^(\d) $0 {} :my $e=$0; ($e) <!before $e>
        ]
    / ?? $1 x 3 !! -1;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is good-integer(12344456), "444", 'works for "12344456"';
    is good-integer(1233334), -1, 'works for "1233334"';
    is good-integer(10020003), "000", 'works for "10020003"';
}

#| Take user provided number like 10020003
multi sub MAIN(Int $int where $int > 99) {
    say good-integer($int);
}
