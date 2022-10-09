sub task1 ( Str $s ) {
    return $s.subst: /(..)(..)\.(..)(..)\.(..)(..)/, *.join(':');
}

use Test;
my @tests =
    <1ac2.34f0.b1c2 1a:c2:34:f0:b1:c2>,
    <abc1.20f1.345a ab:c1:20:f1:34:5a>,
;
plan +@tests;
for @tests -> ($in, $expected) {
    is task1($in), $expected;
}
