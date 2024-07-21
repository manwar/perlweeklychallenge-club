#!/usr/bin/env raku

use v6.d;

sub sort-string(Str $str --> Str) {
    my %str-dict;
    map({ $_ ~~ /^(\w+)(\d)$/; %str-dict{$1} = $0 }, words($str));
    map({%str-dict{$_}}, 1..%str-dict.elems).join: " ";
}

#| Run test cases
multi sub MAIN('test') {
    use Test;
    plan 3;

    is sort-string("and2 Raku3 cousins5 Perl1 are4"),
        "Perl and Raku are cousins", 'works for "and2 Raku3 cousins5 Perl1 are4"';
    is sort-string("guest6 Python1 most4 the3 popular5 is2 language7"),
        "Python is the most popular guest language",
        'works for "guest6 Python1 most4 the3 popular5 is2 language7"';
    is sort-string("Challenge3 The1 Weekly2"), "The Weekly Challenge",
        'works for "Challenge3 The1 Weekly2"';
}

#| Take user provided strings like and2 Raku3 cousins5 Perl1 are4
multi sub MAIN(*@strings where so @strings.all ~~ /^\w+\d$/) {
    say sort-string((@strings.join: " "));
}
