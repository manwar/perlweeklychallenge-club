#!/usr/bin/raku

sub MAIN(
    $separator, *@words
) {
    @words.map({| $_.split($separator) }).grep({ $_ }).map({ "\"$_\"" }).join(q{,}).say;
}