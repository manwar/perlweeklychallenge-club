my &fun = { (@^ints Z~ @^ints.reverse)[^(* div 2)].sum + (@^ints[* div 2] if @^ints !%% 2) }

#`{
- Take an array of things via the implicit signature @^ints
- Zip that array with its reversed version
    - This essentially takes 1 item from beginning and 1 from end together
- We don't need the "repeated" zippings, i.e., past the middle point, it will be mirrored
    - So take until the half of the array via `^(* div 2)` (`*` is passed the array length)
- We are zipping with `~`, i.e., string gluer, so the numbers will be joined together
    - Summation of those glueds will be the end result, except...
- If we had an odd-sized array, the middle guy didn't get accounted for, so we add that
}

use Test;
my @tests of Pair =
    (6, 12, 25, 1) => 1286,
    (10, 7, 31, 5, 2, 2) => 489,
    (1, 2, 10) => 112;

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}
