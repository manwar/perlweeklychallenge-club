#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Str $path_to_dict_file,
) {
    say $path_to_dict_file.IO.words.classify({ $_.lc.comb.Bag }).max({ $_.value.elems }).value
}
