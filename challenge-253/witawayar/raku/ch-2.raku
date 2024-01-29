my &fun =  { @^matrix.map({ $++ => $_ }).sort(-> $a, $b { $a.value.sum <=> $b.value.sum || $a.key <=> $b.key })>>.key };

#`{
- Take the positional matrix parameter implicitly
- Decorate it with the indexes (a Schwartzian transform)
- Sort over the number of 1s first, then the indexes
- Undecorate to get the indexes that would sort
}
use Test;
my @tests of Pair =
    [
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 0],
        [1, 0, 0, 0, 0],
        [1, 1, 0, 0, 0],
        [1, 1, 1, 1, 1]
    ] => (2, 0, 3, 1, 4),
    [
        [1, 0, 0, 0],
        [1, 1, 1, 1],
        [1, 0, 0, 0],
        [1, 0, 0, 0]
    ] => (0, 2, 3, 1);

for @tests -> (:key($input), :value($expected-output)) {
    ok fun($input) eqv $expected-output;
    LAST done-testing;
}
