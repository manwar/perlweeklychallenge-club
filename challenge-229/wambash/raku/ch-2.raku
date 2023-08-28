#!/usr/bin/env raku

sub two-out-of-three (+@arr-of-arr) {
    ([∪] @arr-of-arr) ∖ [⊖] @arr-of-arr
}

multi MAIN (Bool :test($)!) {
    use Test;
    is-deeply two-out-of-three((1,1,2,4),(2,4),(4,)), set(2,4);
    is-deeply two-out-of-three((4,1),(2,4),(1,2)), set(1,2,4);
    done-testing;
}

multi MAIN (:@A,:@B, :@C) {
    say two-out-of-three @A, @B, @C
}
