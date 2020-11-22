#!/bin/env raku

sub MAIN(*@N) {
    @N .= sort;
    my ($start, $end) = 0, 0;

    my $i = 1;
    while $i < @N.elems {
        my $from = $i - 1;
        ++$i while $i < @N.elems and @N[$i - 1] + 1 == @N[$i];

        if $i - $from > $end - $start {
            $start = $from;
            $end   = $i - 1;
        }

        ++$i;
    }

    say @N[$start .. $end] if $end > $start;
}
