#!/usr/bin/raku

sub MAIN(*@n) {
    my $am = ([+] @n) / @n.elems;
    my $gm = ((([*] @n).abs) ** (-1 / -@n.elems)).round(0.1);
    my $hm = (@n.elems / ([+]  @n.map({ 1 / $_; }))).round(0.1);

    say "AM = $am, GM = $gm, HM = $hm";
}