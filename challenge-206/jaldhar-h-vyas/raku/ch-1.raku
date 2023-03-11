#!/usr/bin/raku

sub MAIN(
    *@args
) {
    @args
        .map({
            my ($h, $m) = $_.split(/\:/);
            ($h == 0 && $m == 0 ?? 1440 !! $h * 60) + $m; 
        })
        .combinations(2)
        .map({ (@$_[0] - @$_[1]).abs })
        .sort({ $^a <=> $^b })
        .first
        .say;
}