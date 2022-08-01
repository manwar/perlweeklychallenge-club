#!/usr/bin/raku

sub isPerfectTotient(Int $n) {
    my $total = 0;
    my $current = $n;

    while $current != 0 {
        my $totients = totients($current);
        $total += $totients;
        $current = $totients;
    }

    return $total == $n;
}

sub totients(Int $n) {
    my $tots = 0;
    for 1 ..^ $n -> $i {
        if $i gcd $n == 1 {
            $tots++;
        }
    }

    return $tots;
}

sub MAIN() {
    my @perfectTotients;
    my $n = 1;

    while @perfectTotients.elems < 20 {
        if isPerfectTotient($n) {
            @perfectTotients.push($n);
        }
        $n++;
    }

    @perfectTotients.join(q{, }).say;
}