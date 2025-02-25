#!/usr/bin/env raku

use v6.d;

sub sort-large(Int $x, Int $y --> Order) {
    my @x-digits = $x.comb;
    my @y-digits = $y.comb;
    return Less if @x-digits[0] > @y-digits[0];
    return More if @x-digits[0] < @y-digits[0];
    return $x leg $y if $x.chars == $y.chars;
    if @x-digits.elems > @y-digits.elems {
        if $x.starts-with: $y {
            return @x-digits[0] leg @x-digits[$y.chars];
        }
        return $y leg @x-digits[0..@y-digits.elems - 1].join;
    }
    if $y.starts-with: $x {
        return @y-digits[$x.chars] leg @y-digits[0];
    }
    return @y-digits[0..@x-digits.elems - 1].join leg $x;
}

sub ln(@ints --> Int) {
    @ints.sort(&sort-large).join.Int;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is ln([20, 3]), 320, 'works for "[20, 3]"';
    is ln([3, 30, 34, 5, 9]), 9534330, 'works for "[3, 30, 34, 5, 9]"';
}

#| Take user provided numbers like 3, 30, 34, 5, 9
multi sub MAIN(*@ints) {
    say ln(@ints);
}

