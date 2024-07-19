#!/usr/bin/env raku

sub sort-string ($str) {
    $str
    andthen .match: /(<alpha>+)(\d+)/, :g
    andthen .sort: *.[1]
    andthen .map: *.[0]
    andthen .Str
}

multi MAIN (Bool :test($)!) {
    use Test;
    is sort-string('and2 Raku3 cousins5 Perl1 are4'),'Perl and Raku are cousins';
    is sort-string('guest6 Python1 most4 the3 popular5 is2 language7'), 'Python is the most popular guest language';
    is sort-string('Challenge3 The1 Weekly2'), 'The Weekly Challenge';
    is sort-string('b2 d4 c3 a1'), 'a b c d';
    done-testing;
}

multi MAIN ($str) {
    say sort-string $str
}
