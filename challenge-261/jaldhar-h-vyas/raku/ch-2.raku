#!/usr/bin/raku

sub MAIN(
    $start,
    *@ints
) {
    my $end = $start;
    for 0 .. @ints.end -> $i {
        if ($end == @ints[$i]) {
            $end *= 2;
        }
    }

    say $end;
}