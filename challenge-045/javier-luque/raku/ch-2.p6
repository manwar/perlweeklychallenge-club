# Test: perl6 ch-2.p6 | diff - ch-2.p6
use v6.d;

sub MAIN () {
    for $*PROGRAM-NAME.IO.lines -> $line {
        say $line;
    }
}
