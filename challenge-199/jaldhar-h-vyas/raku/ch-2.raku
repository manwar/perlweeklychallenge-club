#!/usr/bin/raku

sub MAIN(
    Int :$x, Int :$y, Int :$z, *@array
    where { defined $x && defined $y && defined $z && @array.elems }
) {
    my @goodtriplets;

    for 0 .. @array.end -> $i {
        for $i ^.. @array.end -> $j {
            for $j ^.. @array.end -> $k {
                if (@array[$i] - @array[$j]).abs <= $x &&
                   (@array[$j] - @array[$k]).abs <= $y &&
                   (@array[$i] - @array[$k]).abs <= $z {
                        @goodtriplets.push(@array[$i,$j,$k]);
                }
            }
        }
    }

    @goodtriplets.elems.say;
}