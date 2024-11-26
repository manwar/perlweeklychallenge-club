#!/usr/bin/raku

sub MAIN(*@ints) {
    my $longest = 0;

    while @ints.elems > 1 {
        my $length = (@ints.join.match(/([01|10]+)/, :g))[0] ?? $0.chars !! 0;

        if $length > $longest {
            $longest = $length;
        }

        shift @ints;
    }

    say $longest;
}