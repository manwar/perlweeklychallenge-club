#!/usr/bin/raku

sub MAIN(
    $str,
    Int $k
) {
    if $k == 1 {
        my $smallest = $str;

        for 0 ..^ $str.chars -> $i {
            my $rotation = $str.substr($i) ~ $str.substr(0, $i);
            if $rotation lt $smallest {
                $smallest = $rotation;
            }
        }

        say $smallest;
    } else {
        $str.comb.sort.join.say;
    }
}
