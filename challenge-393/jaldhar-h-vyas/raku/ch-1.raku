#!/usr/bin/raku

sub MAIN(
    $n
) {
    my $count = 0;

    for 1 .. $n -> $a {
        for 1 .. $n -> $b {
            my $c = ($a² + $b²).sqrt;
            if  $c <= $n && $c.Int == $c {
                $count++;
            }
        }
    }

    say $count;
}
