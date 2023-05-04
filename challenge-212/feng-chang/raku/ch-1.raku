#!/bin/env raku

unit sub MAIN(*@N);

sub USAGE() {
    print Q:c:to/END/;
    Usage: {$*PROGRAM-NAME} <word> <integer> ...
        Word should contain alphabetic characters only, and 
        the number of integers should be equal to word length.
    END
}

if +@N == 0                       or
   @N[0] !~~ /^ <[a..z A..Z]>+ $/ or
   @N[0].chars !== +@N - 1 {
    USAGE();
    exit 1;
}

my method jump-characters(Str:D $c : UInt:D $n --> Str:D) {
    given $c {
        when 'a'..'z' { chr((ord($c) - ord('a') + $n) % 26 + ord('a')) }
        when 'A'..'Z' { chr((ord($c) - ord('A') + $n) % 26 + ord('A')) }
    }
}

put @N[0].comb.pairs.map({ .value.&jump-characters(@N[.key + 1]) }).join;
