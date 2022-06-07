#!/usr/bin/raku

sub MAIN() {
    my @circularPrimes;
    my $n = 99;

    outer: while @circularPrimes.elems < 10 {
        $n++;

        unless $n ~~ /^ <[1379]>+ $/ {
            next;
        }

        my $rotated = $n;
        for 0 ..^ $n.chars {
            unless $rotated.is-prime && $rotated.Int ∉ @circularPrimes {
                next outer;
            }

            $rotated = $rotated.substr(1 .. *) ~ $rotated.substr(0, 1);
        }
        @circularPrimes.push($n);
    }

    @circularPrimes.join(q{, }).say;
}