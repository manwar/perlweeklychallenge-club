#!/usr/bin/raku

sub isMountain(@ints) {
    if @ints.elems < 3 {
        return False;
    }

    my $i = 0;

    while $i < @ints.end && @ints[$i] < @ints[$i + 1] {
        $i++;
    }

    if $i == 0 || $i == @ints.end {
        return False;
    }

    while $i < @ints.end && @ints[$i] > @ints[$i + 1] {
        $i++;
    }

    return $i == @ints.end;
}

sub MAIN(
    *@ints
) {
    say isMountain(@ints);
}
