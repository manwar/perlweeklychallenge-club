#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @intervals = @args.map({ $_.split(q{,})».Int.minmax });
    my @overlaps;

    for (1 .. @intervals.end) -> $i {
        for (0 ..^ $i) -> $j {
            if (@intervals[$i] ∩ @intervals[$j]) {
                @overlaps.push(@intervals[$i].bounds);
                last;
            }
        }
    }
    say '[ ', @overlaps.map({ q{(} ~ $_.join(q{,}) ~ q{)} }).join(q{, }), ' ]';
}