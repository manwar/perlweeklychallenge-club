#!/usr/bin/raku

sub hasEightDivisors(Int $n) {
    return (1 .. $n).grep({ $n %% $_; }).elems == 8;
}

sub MAIN() {

    my @eightDivisors;
    my $n = 2;

    while @eightDivisors.elems < 10 {
        if hasEightDivisors($n) {
            @eightDivisors.push($n);
        }
        $n++;
    }

    say join q{, }, @eightDivisors;
}