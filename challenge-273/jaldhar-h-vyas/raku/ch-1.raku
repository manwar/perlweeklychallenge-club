#!/usr/bin/raku

sub MAIN(
    Str $str,
    Str $chr
 ) {
    $str.comb.classify({ $_ }, into => my %freq);
    say %freq{$chr}:exists ?? (%freq{$chr}.elems / $str.chars * 100).round !! 0;
}