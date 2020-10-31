#!/usr/bin/env raku

sub reverse-integer ($n) {
    with $n.abs.flip * $n.sign {
        when -2³¹ ..^ 2³¹ { $_ };
        default           { 0  };
    }
}

multi MAIN (Int $n) {
    say reverse-integer $n
}

multi MAIN (Bool :$test!) {
    use Test;
    is reverse-integer(1234), 4321;
    is reverse-integer(-1234), -4321;
    is reverse-integer(1231230512), 0;
    done-testing;
}
