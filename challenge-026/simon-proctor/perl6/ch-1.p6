#!/usr/bin/env perl6

use v6;

subset SimpleLetters of Str where * ~~ /^ <[ a..z A..Z ]>+ $/;

#| Document script
multi sub MAIN( Bool :h(:$help) where ?* ) { say $*USAGE }

#| print the count of letters in "jewels" there appear in "stones"
multi sub MAIN(
    SimpleLetters $stones, #= String to find letters in
    SimpleLetters $jewels  #= String of letters to look for
) {
    my $stone-set = $stones.comb.Set;
    $jewels.comb.grep( { $_ (elem) $stone-set } ).elems.say;
}
