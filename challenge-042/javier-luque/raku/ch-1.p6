# Test: perl6 ch-1.p6
use v6.d;

sub MAIN() {
    for (1..50) -> $i {
        say 'Decimal '  ~ $i ~
            ' = Octal ' ~ to-octal($i);
    }
}

sub to-octal(Int $i) {
    return sprintf('%o', $i);
}
