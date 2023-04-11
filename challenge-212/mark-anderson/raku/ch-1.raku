#!/usr/bin/env raku
use Array::Circular;
use Test;

is jumping-letters("Perl", (2,22,19,9)),   "Raku";
is jumping-letters("Raku", (24,4,7,17)),   "Perl";
is jumping-letters("Perl", (54,74,71,61)), "Raku";
is jumping-letters("Raku", (76,56,59,69)), "Perl";

sub jumping-letters($word, *@jump)
{
    my $uc = flat '' xx 65, ('A'..'Z').Slip xx *;
    my $lc = flat '' xx 97, ('a'..'z').Slip xx *;

    sub jump($letter, $jump)
    {
        my $list := $letter.ord < 97 ?? $uc !! $lc;
        $list[$letter.ord + $jump]
    }
    
    ($word.comb Z @jump).map({ jump(.[0], .[1]) }).join
}
