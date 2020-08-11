#!/usr/bin/env perl6

sub MAIN(Str $stones, Str $jewels) {

    sub collect(Str $s) { $s.comb(/<[A..Z a..z]>/).Bag }

    say [+] collect($stones){collect($jewels).keys};
}
