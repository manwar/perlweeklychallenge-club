#!/usr/bin/env raku

use v6.d;

sub count-ones(@str --> List) {
    my Str $joined-str = @str.join;
    my Int $summed-str = $joined-str.comb.sum;
    ($joined-str.chars - $summed-str, $summed-str);
}

sub is-valid(@str, $x, $y --> Bool) {
    my ($zeroes, $ones) = count-ones(@str);
    return $zeroes ≤ $x and  $ones ≤ $y;
}

sub ones-and-zeroes(@str, $x, $y --> Int) {
    for min(@str.elems, $x + $y)...1 -> $n {
        return $n if map({ is-valid($_, $x, $y) }, @str.combinations: $n).any == True;
    }
    return 0;
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 2;

    is ones-and-zeroes(["10", "0001", "111001", "1", "0"], 5, 3), 4,
        'works for "["10", "0001", "111001", "1", "0"], 5, 3"';
    is ones-and-zeroes(["10", "1", "0"], 1, 1), 2,
        'works for "["10", "1", "0"], 1, 1"';
}

#| Take user provided numbers like 1 1 "10", "1", "0"
multi sub MAIN($x, $y, *@ints) {
    say ones-and-zeroes(@ints, $x, $y);
}

