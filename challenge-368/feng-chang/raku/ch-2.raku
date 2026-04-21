#!/bin/env raku

unit sub MAIN(Int:D $n, Int:D $mode);

sub factors(Int:D $n where * > 1) {
    my $m = $n;
    my @a;

    for (^∞).grep: *.is-prime -> $p {
        while $m %% $p {
            @a.push($p);
            $m div= $p;
        }

        last if $m < $p²;

        LAST { @a.push($m) if $m > 1; }
    }

    @a
}

put do given $mode {
    when 0 { +factors($n).unique }
    when 1 { +factors($n) }
}
