#!/usr/bin/raku

sub MAIN(
     *@ints
) {
    my $swaps = 0;

    while @ints[0] != 1 && @ints[*-1] != @ints.elems {
        for 1 .. @ints.end -> $i {
            if @ints[$i - 1] > @ints[$i] {
                my $temp = @ints[$i];
                @ints[$i] = @ints[$i - 1];
                @ints[$i - 1] = $temp;
                $swaps++;
            }
        }
    }

    say $swaps;
}