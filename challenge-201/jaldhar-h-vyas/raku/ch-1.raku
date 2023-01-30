#!/usr/bin/raku

sub MAIN(
    *@array
) {
    my @need = 0 .. @array.elems;
    my Set $missing = @need ∖ @array.map({ $_.Int });

    $missing.keys.join(q{, }).say;
}