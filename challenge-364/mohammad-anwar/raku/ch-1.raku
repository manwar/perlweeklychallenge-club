#!/usr/bin/env raku

use Test;

my %examples =
    "10#11#12"  => "jkab",
    "1326#"     => "acz",
    "25#24#123" => "yxabc",
    "20#5"      => "te",
    "1910#26#"  => "aijz";

is decrypt-string($_), %examples{$_} for %examples.keys;

done-testing;

sub decrypt-string(Str $str --> Str) {
    return $str.subst(/(\d**2)'#' | (\d)/, { chr(($0 // $1).Int + 96) }, :g);
}
