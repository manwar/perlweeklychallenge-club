my &fun = { $_ =~= .round given $^n.abs ** (1 / 3) };

#`{
- Take implicitly the scalar $^n
- Take its cube root after absoluted
    - Raku gives NaN for negative values to fractional powers
    - e.g., (-5) ** (3 / 2) ?==? sqrt(-125)
- Check if it is approximately equal to its rounded form
    - If so, it was an integer "modulo" floating point issues
}
use Test;
my @tests of Pair =
    0 => True,
    1 => True,
    -343 => True,
    27 => True,
    122 => False,
    6 => False,
    777 => False;

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}
