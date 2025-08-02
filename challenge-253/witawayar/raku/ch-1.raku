my &fun = -> @words, $separator { @words>>.split($separator).flat.grep(?*).list };

#`{
- Since "words" come after "separator", opted for an explicit signature
- Split each item in words over the separator
    - `>>` the hyper operator acts like a `map` here
- Then flatten out the splitted strings
- And eliminate empty ones by grepping for truthful strings
}
use Test;
my @tests of Pair =
    (("one.two.three", "four.five", "six"), ".") => ("one", "two", "three", "four", "five", "six"),
    (("\$perl\$\$", "\$\$raku\$"), "\$") => ("perl", "raku");

for @tests -> (:key(($words, $sep)), :value($expected-output)) {
    ok fun(@$words, $sep) eqv $expected-output;
    LAST done-testing;
}
