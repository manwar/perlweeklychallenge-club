#!/usr/bin/raku

sub MAIN(
    $str
) {
    my @characters = $str.comb;

    my @uppers;
    for @characters.keys -> $pos {
        if @characters[$pos] ~~ /<[A..Z]>/ {
            @uppers.push($pos);
        }
    }

    my @swaps;

    for 0, 1 -> $offset {
        my $swap = 0;
        my $i = 0;

        for @characters.keys -> $pos {
            if $pos % 2 == $offset {
                $swap += (@uppers[$i] - $pos).abs;
                $i++;
            }
        }

        @swaps.push($swap);
    }

    say @swaps.min;
}
