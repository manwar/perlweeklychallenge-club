#!/usr/bin/env raku
use Test;

is first-unique-char("Perl Weekly Challenge"), 0;
is first-unique-char("Long Live Perl"),        1;
is first-unique-char("We Will We Will Raku"),  16;

sub first-unique-char($str)
{
    my @a = $str.comb;
    my $s := @a.repeated.Set;
    @a.first(* !(elem) $s, :k)
}
