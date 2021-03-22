#!/usr/bin/raku

multi sub fusc(
    Int $n where { $n == 0 }
) {
    return 0;
}

multi sub fusc(
    Int $n where { $n == 1 }
) {
    return 1;
}

multi sub fusc(
    Int $n where { ($n > 1) && ($n % 2 == 0); }
) {
    return fusc($n div 2);
}

multi sub fusc(
    Int $n where { ($n > 1) && ($n % 2 == 1); }
) {
    return fusc(($n - 1) div 2) + fusc(($n + 1) div 2);
}

sub MAIN () {
    for ^50 -> $n {
        print fusc($n), ' ';
    }

    print "\n";
}

