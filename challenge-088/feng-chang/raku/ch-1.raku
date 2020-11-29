#!/bin/env raku

sub MAIN(*@N) {
    say @N.map: ([*] @N) / *;
}
