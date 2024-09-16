#!/usr/bin/raku

sub MAIN(
    *@args
) {
    my @ints = @args;

    while (@ints.elems > 1) {
        my @next;
        for 1 .. @ints.end -> $i {
            @next.push($i %% 2
                ?? (@ints[$i- 1], @ints[$i]).max
                !! (@ints[$i - 1], @ints[$i]).min
            );
        }
        @ints = @next;
    }

    say @ints[0];
}
