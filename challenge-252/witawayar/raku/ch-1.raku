my &fun = { @^ints.kv.map({ $^value ** 2 if +@ints %% $^index.succ }).sum }

#`{
- Take an array of things via the implicit signature @^ints
- Reach its "keys" and "values" via `.kv`
    - Keys are the 0-based indexes, values are, well, the values themselves
    - This gives a 2N length sequence
- We can `.map` the interleaved key-value sequence via an implicit signature
    - Lexicographically, index < value, so when taking 2 things at a time (since arity == 2),
      `.map` will assign the first one (key) to $^index, second one (value) to $^value
- Then accumulate value squared if index's "succ"essor (index + 1) is a divisor of @^ints' length
}

use Test;
my @tests of Pair =
    (1, 2, 3, 4) => 21,
    (2, 7, 1, 19, 18, 3) => 63;

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}
