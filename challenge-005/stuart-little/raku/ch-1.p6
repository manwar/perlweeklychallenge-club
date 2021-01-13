#!/usr/bin/env perl6
use v6;

my %*SUB-MAIN-OPTS=:named-anywhere,;
sub MAIN(
    Str $word,
    Str $path_to_dict_file,
) {
    say anagrams($word, $path_to_dict_file.IO.slurp.words)
}

sub anagrams($word,@words) {
    my $bag=$word.lc.comb.Bag;
    return @words.grep({ $_.lc.comb.Bag === $bag })
}
