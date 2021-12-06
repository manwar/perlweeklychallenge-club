#!/usr/bin/env raku

#| Find the first N positive integers with exactly X divisors
sub MAIN(
    \N = 10, #= Number of integers (default 10)
    \X = 8, #= Number of divisors (default 8)
) {
    .say for (1..*).grep(
        -> $v {
            (1..$v).grep(
                -> $d {
                    $v %% $d
                } ).elems == X
        })[^N];
}
