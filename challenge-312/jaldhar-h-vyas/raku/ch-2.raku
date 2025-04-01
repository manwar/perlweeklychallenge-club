#!/usr/bin/raku

sub MAIN(
    Str $str
) {
    my @boxes;

    for $str.match(/(<[RGB]>) (\d)/, :g) -> ($color, $box) {
        @boxes[$box]{$color} = True;
    }

    @boxes.grep({ %$_.keys.elems == 3 }).elems.say;
}
