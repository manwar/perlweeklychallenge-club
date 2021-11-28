#!/bin/env raku

sub MAIN(*@N) {
    my UInt $num = @N.elems div 2;
    my Int  $sum = @N.sum;
    my UInt $min = @N.combinations($num).map({ abs($sum - 2 * $_.sum) }).min;

    @N.combinations($num).map({
        if abs($sum - 2 * $_.sum) == $min {
            put $_.join(' ');
            put (@N (-) $_).keys.join(' ');
            put ' = ' x 3;
        }
    });
}

# todo: when size is even, output should be cut to half
