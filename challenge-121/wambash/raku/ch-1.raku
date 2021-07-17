#!/usr/bin/env raku

sub invert-bit ($m, $n) {
    $m +^ 2**($n-1)
}

multi MAIN ($m, $n) {
    say invert-bit $m, $n
}

multi MAIN (Bool :test($)!) {
    use Test;
    is invert-bit(12,3), 8;
    is invert-bit(18,4), 26;
    done-testing;
}
