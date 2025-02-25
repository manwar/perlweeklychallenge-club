#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %diffs;
    for 1 .. @ints.end -> $i {
        %diffs{ @ints[$i] - @ints[$i - 1] }.push(@ints[$i]);
    }

    say %diffs{%diffs.keys».Int.min}[0];
}
