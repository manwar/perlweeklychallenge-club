#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %h;
    for @ints.keys -> $i {
        %h{@ints[$i]} = $i;
    }

    my @sorted = %h.keys.sort({ $^a <=> $^b});

    say @sorted[*-1] >= @sorted[*-2] * 2 ?? %h{@sorted[*-1]} !! -1;
}
