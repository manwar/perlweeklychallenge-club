#!/usr/bin/perl6

sub MAIN(*@N) {
    my @n = @N.sort;
    my @sequence = ( @n[0] );
    my @longest;

    for 1 ..^ @n.elems  -> $i {
        if @n[$i] == @n[$i - 1] + 1 {
            @sequence.push(@n[$i]);

            if @sequence.elems > @longest.elems {
                @longest = @sequence;
            }

        } else {
            @sequence = ( @n[$i] );
        } 
    }

    say @longest.elems ?? (q{(} ~ @longest.join(q{, }) ~ q{)}) !! 0;
}