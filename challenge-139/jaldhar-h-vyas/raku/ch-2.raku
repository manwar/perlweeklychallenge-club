#!/usr/bin/raku

sub period(Int $n) {
    my $remainder = 1;
    my $i = 1;
    my %position;

    loop {
        $remainder = (10 * $remainder) % $n;
        if %position{$remainder}:exists {
            return $i - %position{$remainder};
        }
        %position{$remainder} = $i;
        $i++;
    }
}

sub MAIN() {
    my $p = 2;
    my @longPrimes;

    while (@longPrimes.elems < 5) {
        $p++;

        unless $p.is-prime {
            next;
        }

        if period($p) == $p - 1 {
            @longPrimes.push($p);
        }
    }

    @longPrimes.join(q{, }).say;
}