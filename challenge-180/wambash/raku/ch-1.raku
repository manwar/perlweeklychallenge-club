#!/usr/bin/env raku

multi first-unique-charakter (Str $s) {
    nextwith $s.comb
}

multi first-unique-charakter (+@s) {
    my %letter := @s.Bag;
    @s.first: { %letter{$_} == 1 }
}

multi MAIN (Bool :test($)!) {
    use Test;
    is first-unique-charakter('Perl Weekly Challenge'),'P';
    is first-unique-charakter('Long Live Perl'),'o';
    is first-unique-charakter('P'),'P';
    done-testing;
}

multi MAIN ($s) {
    say first-unique-charakter $s
}
