#!/bin/env raku

multi sub MAIN(1) {
    say 1;
}

multi sub MAIN($N where * > 1) {
    for 2..^$N -> $b {
        for 2,3 ...^ * ** $b > $N -> $a {
            if $a**$b == $N {
                say 1;
                exit;
            }
        }
    }

    say 0;
}
