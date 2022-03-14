#!/usr/bin/raku

sub π($n) {
    my @fibs = 0, 1, -> $a, $b { $a + $b} ... ∞;

    my $i = 2;
    loop {
        my @moduli = @fibs[0 ..^ $i].map({ $_ mod $n; });
        if (@moduli[0 ..^ $i / 2] Z== @moduli[$i / 2 .. *]).all {
            return $i / 2;
        }
        $i += 2;
    }
}

sub MAIN() {
    say π(3);
}