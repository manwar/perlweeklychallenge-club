#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @peaks;

    if @ints[0] > @ints[1] {
        @peaks.push(0);
    }

    for 1 ..^ @ints.end -> $i {
        if @ints[$i -1] < @ints[$i] > @ints[$i + 1] {
            @peaks.push($i);
        }
    }

    if @ints[*-1] > @ints[*-2] {
        @peaks.push(*-1);
    }

    say  q{(}, @peaks.join(q{, }), q{)};
}
