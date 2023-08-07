#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $ops = 0;

    while @ints.elems {
        if @ints[0] == @ints.min {
            @ints.shift;
        } else {
            @ints.push(@ints.shift);
        }
        $ops++;
    }

    say $ops;
}