#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my $result = -1;

    for 0 .. @ints.end -> $i {
        if @ints[$i] % 10 == $i {
            $result = $i;
            last;
        }
    }

    say $result;
}