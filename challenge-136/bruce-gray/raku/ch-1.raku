# From http://graphics.stanford.edu/~seander/bithacks.html#DetermineIfPowerOf2
sub is-power-of-two ( UInt $x --> Bool ) { return ( $x +& ($x - 1) ) == 0 }

sub are-two-friendly ( UInt $m, UInt $n --> Bool ) {
    my $g = $m gcd $n;
    return $g > 1 && is-power-of-two($g);
}

use Test;
my @tests = 
    ( 8, 24) => True,
    (26, 39) => False,
    ( 4, 10) => True,

    (40, 48) => True,
    ( 8, 64) => True,
    ( 8,  1) => False,
    ( 6, 18) => False,
;
plan +@tests;
for @tests -> ( :key(@input), :value($expected) ) {
    is are-two-friendly(|@input), $expected,
        "are-two-friendly {@input.fmt('%2d')} == $expected";
}
