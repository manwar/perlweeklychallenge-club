#!/usr/bin/env raku
use Test;

is reverse-degree("z"),         1;
is reverse-degree("a"),        26;
is reverse-degree("bbc"),     147;
is reverse-degree("racecar"), 560;
is reverse-degree("zyx"),      14;

sub reverse-degree($str)
{
    my @a = $str.comb;
    my %h is Map = 'a'..'z' >>=><< (26...1);
    sum (1..@a) >>*<< %h{@a}
}
