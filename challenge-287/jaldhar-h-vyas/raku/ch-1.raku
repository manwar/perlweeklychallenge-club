#!/usr/bin/raku


sub MAIN(
    Str $str is copy
) {
    my $steps = 0;

    my $digits = ('0' .. '9').join;
    my $lower = ('a' .. 'z').join;
    my $upper = ('A' .. 'Z').join;
    my $all = $digits ~ $lower ~ $upper;
    my $nondigits = $lower ~ $upper;
    my $nonlower = $digits ~ $upper;
    my $nonupper = $digits ~ $lower;

    while $str ~~ /(.)$0$0/ {
        my $chars = $0.Str ~~ $lower
            ?? $nonlower
            !! $0.Str ~~ $upper
                ?? $nonupper
                !! $digits;
        $str = $str.subst($/, $/.substr(0, 2) ~ $chars.comb.pick(1).first);
        $steps++;
    }

    if $str !~~ / @($digits.comb) / {
        $str ~= $digits.comb.pick(1).first;
        $steps++;
    }

    if $str !~~ / @($lower.comb) / {
        $str ~= $lower.comb.pick(1).first;
        $steps++;
    }

    if $str !~~ / @($upper.comb) / {
        $str ~= $upper.comb.pick(1).first;
        $steps++;
    }

    while $str.chars < 6 {
        $str ~= $all.comb.pick(1).first;
        $steps++;
    }

    say $steps;
}
