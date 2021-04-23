#!/usr/bin/raku

sub MAIN(
    Str $name,
) {
    my $stem = $name.subst(/^ <-[AaEeIiOoUu]> /, q{}).lc;
    my Bool $labial = $name.match(/^ <[BbFfMm]> /).Bool;
    say "$name, $name, bo-", $labial ?? q{} !! 'b', "$stem";
    say "Bonana-fana fo-", $labial ?? q{} !! 'f', "$stem";
    say "Fee fi mo-", $labial ?? q{} !! 'm', "$stem";
    say "$name!";
}