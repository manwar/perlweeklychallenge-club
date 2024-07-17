#! /usr/bin/raku

use Test;

plan 3;

is(sortstring('and2 Raku3 cousins5 Perl1 are4'), 'Perl and Raku are cousins', 'example 1');
is(sortstring('guest6 Python1 most4 the3 popular5 is2 language7'), 'Python is the most popular guest language', 'example 2');
is(sortstring('Challenge3 The1 Weekly2'), 'The Weekly Challenge', 'example 3');

sub sortstring($a) {
    my @words = $a.split(' ');
    my @out = ["" xx @words.elems];
    for @words -> $w {
        $w ~~ /^(.*?)(<[0..9]>+)$/;
        @out[$1 - 1] = $0 ~ '';
    }
    return @out.join(' ');
}
