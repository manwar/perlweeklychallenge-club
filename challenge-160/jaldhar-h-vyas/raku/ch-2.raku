#!/usr/bin/raku

sub MAIN(
    *@n
) {
    for 0 ..^ @n.elems -> $i {
        if ([+] @n[0 ..^ $i]) == ([+] @n[$i ^..^ @n.elems]) {
            say $i;
            exit;
        }
    }

    say -1;
}