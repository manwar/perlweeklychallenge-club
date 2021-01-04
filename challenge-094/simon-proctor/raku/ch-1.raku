#!/usr/bin/env raku

use v6;

#| Given a list of strings print out sets of anagrams 1 line per set
multi sub MAIN( *@strings ) {
    my %results;

    for @strings -> $string {
        my $key = $string.comb.sort.join("");
        %results{$key} //= [];
        %results{$key}.push($string);
    }

    .join(" ").say for %results.values;
}
