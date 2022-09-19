use Prime::Factor;

sub HP ( UInt $n is copy where * > 1 --> UInt ) {
    # Could have also used:
    # return ( $n, { + .&prime-factors.join } … &is-prime ).tail;

    $n = $n.&prime-factors.join.Int until $n.is-prime;
    return $n;
}


if @*ARGS {
    say "HP({$_}) = {HP(+$_)}" for @*ARGS;
}
else {
    use Test;
    plan 1;

    # From https://oeis.org/A037274
    constant @expected = 2, 3, 211, 5, 23, 7, 3331113965338635107, 311, 773, 11, 223, 13, 13367, 1129, 31636373, 17, 233, 19, 3318308475676071413, 37, 211, 23, 331319, 773, 3251, 13367, 227, 29, 547, 31, 241271, 311, 31397, 1129, 71129, 37, 373, 313, 3314192745739, 41, 379, 43, 22815088913, 3411949, 223, 47, 6161791591356884791277;

    is-deeply (2..48).map(&HP), @expected.Seq;
}