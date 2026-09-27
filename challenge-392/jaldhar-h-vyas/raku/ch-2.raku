#!/usr/bin/raku

sub MAIN(
    *@words
) {
    my $longest = 0;

    for 1 .. @words.end -> $i {
        for 0 ..^ $i -> $j {
            if (@words[$i].comb ∩ @words[$j].comb).elems == 0 {
                my $len = @words[$i].chars * @words[$j].chars;
                if $len > $longest {
                    $longest = $len;
                }
            }
        }
    }

    say $longest;
}
