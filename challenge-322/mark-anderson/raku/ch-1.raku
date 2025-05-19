#!/usr/bin/env raku
use Test;

is format-string("ABC-D-E-F", 3), "ABC-DEF";
is format-string("A-BC-D-E",  2), "A-BC-DE";
is format-string("-A-B-CD-E", 4), "A-BCDE";

sub format-string($str is copy, $int)
{
    $str ~~ s:g/"-"//;
    my $m = "." x ($str.chars mod $int or $int);
    my $i = "." x $int;
    S:g/<?after <$m>> (<$i>)/-$0/ given $str
}

sub format-string-v2($str, $int)
{
    my @chars = $str.comb(/<upper>/);
    my $list = flat (@chars mod $int or Empty), ($int, $int...*);
    @chars.rotor($list)>>.join.join("-")
}
