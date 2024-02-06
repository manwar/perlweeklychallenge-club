#!/usr/bin/raku

sub MAIN(
    *@a where { @a.elems == 5; } #= a sequence of five integers
) {

    for -10 .. 10 -> $p {
        for -10 .. 10 -> $q {
            if @a[3] ==  $p * @a[1] + $q * @a[2] && @a[4] ==  $p * @a[2] + $q * @a[3] {
                say 'true';
                exit;
            }
        }
    }

    say 'false';
}