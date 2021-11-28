#!/bin/env raku

sub is-palindrome(UInt:D $n --> Bool:D) { $n.flip == $n }

sub is-lynchel(UInt:D $n --> Bool:D) {
    my UInt $m = $n;
    my UInt $cnt;

    repeat {
        return False if is-palindrome($m);

        $m += $m.flip;
        ++$cnt;
    } while $cnt < 500;

    ! is-palindrome($m)
}

sub MAIN(UInt:D $n) {
    put +is-lynchel($n);
}
