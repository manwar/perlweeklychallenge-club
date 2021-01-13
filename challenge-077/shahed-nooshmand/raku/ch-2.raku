#!/usr/bin/env raku

my @matrix =
    <O O X O>,
    <X O O O>,
    <X O O X>,
    <O X O O>;

.say for (^@matrix X ^@matrix[0]).grep: -> ($i, $j) {
    @matrix[$i; $j] eq 'X' and not (<1 0 -1> X <1 0 -1>).grep: -> ($x, $y) {
        $x | $y and do $_ eq 'X' with @matrix[$i + $x; $j + $y]
    }
}
