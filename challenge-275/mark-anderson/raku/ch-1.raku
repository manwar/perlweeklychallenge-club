#!/usr/bin/env raku
use Test;

is broken-keys("Perl Weekly Challenger", <l a>), 0;
is broken-keys("Perl and Raku", <a>),            1;
is broken-keys("Well done team PWC", <l o>),     2;
is broken-keys("The joys of polyglottism", <T>), 2;

sub broken-keys
{
    my $s = $^a.fc;
    my $k = $^b>>.fc;

    + $s.words.grep({ .comb.any !~~ $k.any })
}
