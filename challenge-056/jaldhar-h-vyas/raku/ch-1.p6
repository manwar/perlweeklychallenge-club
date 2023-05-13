#!/usr/bin/raku

sub MAIN(
    $k, *@N
) {
    for 0 .. @N.end X 0 .. @N.end -> $combo {
        if @N[@$combo[0]] - @N[@$combo[1]] == $k && @$combo[0] != @$combo[1] {
            say @$combo.join(q{,});
        }
    }
}