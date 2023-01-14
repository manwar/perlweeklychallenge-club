#!/usr/bin/raku

sub MAIN(*@list) {
    my @goodpairs;

    for 0 .. @list.end -> $i {
        for $i ^.. @list.end -> $j {
            if @list[$j] == @list[$i] {
                @goodpairs.push(($i, $j));
            }
        }
    }

    @goodpairs.elems.say;
}