#!/usr/bin/perl6

sub isPower($num) {
    my @results;

    if $num > 1 {
        for 2 .. sqrt($num) -> $m {
            my $n = 2;
            my $p = $m ** $n;

            while $p <= $num && $p > 0 {
                if $p == $num {
                    @results.push([$m, $n].join(q{^}));
                }
                $n++;
                $p = $m ** $n;
            }
        }
    }

    return @results;
}

sub MAIN(Int $N) {
    say isPower($N).elems ?? 1 !! 0;
}