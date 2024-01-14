my &fun = { (@^matrix>>.min ∩ ([Z] @^matrix)>>.max).head.key // -1 }

#`{
- Take single positional Positional argument, @^matrix
- Take the minimum of each row -- `>>.min` is like `.map(&min)` here
    - `>>` !== `map` in general though: https://www.reddit.com/r/rakulang/comments/zg4rrq/comment/izgrvt3/?utm_source=share&utm_medium=web2x&context=3
- Take the maximum of each column
    - We first "transpose" the ArrayOfArrays with self-zipping
    - Then take each now-rows' maximal values
- Intersection of row-minimals and column-maximals is the result
    - `∩` is the intersection operator (`(&)` in ASCII); operands need not be Setty
    - The result is a Set -- we need its first (and perhaps the only) element
    - We reach the first one via `.head`
    - But since Sets are Maps in disguise with values being `True`, we need a `.key` further
- If no such intersection exists, we got `Nil`, so `//` (defined-or) will route to -1
}

use Test;
my @tests of Pair =
    [[ 3,  7,  8],
     [ 9, 11, 13],
     [15, 16, 17]] => 15,
    [[ 1, 10,  4,  2],
     [ 9,  3,  8,  7],
     [15, 16, 17, 12] ] => 12,
    [[7, 8],
     [1, 2]] => 7,
    [[7, 8],
     [13, 2]] => -1;

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}
