#!/usr/bin/env perl6

use v6.d;

#| Give two or more equal length strings
#| splits them and writes them down wards
#| Note the challenge asks for arrays but passing in strings is just easier.
sub MAIN(
    *@inputs where { @_.all.codes ~~ @_[0].codes } #= Strings to display
) {
    ([Z] @inputs.map(*.comb)).map(*.join(" ").say);
}
