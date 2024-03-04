#!/bin/env raku

unit sub MAIN(*@ints where *.all > 1);

sub prime-factors(UInt:D $n) {
    my Int $m = $n;
    my @factors;
    my $cnt = 0;

    for (^Inf).grep: *.is-prime -> $p {
        while ($m %% $p) {
            @factors.push($p);
            ++$cnt;
            $m div= $p;
        }

        last if $m < $p * $p;
    }

    if $m > 1 {
        @factors.push($m);
        ++$cnt;
    }

    $cnt, |@factors
}

put @ints.sort({ prime-factors($_) });
