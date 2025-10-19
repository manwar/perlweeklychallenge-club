#!/usr/bin/raku

sub MAIN(
    $str,
) {
    my $max = -∞;

    for (1 ..^ $str.chars) -> $i {
        my $score = $str.substr(0, $i).match(/(0)/, :g).elems +
            $str.substr($i).match(/(1)/, :g).elems;

        if ($score > $max) {
            $max = $score;
        }
    }

    say $max;
}