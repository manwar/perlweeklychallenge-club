#!/usr/bin/env raku
use Test;

is jumping-letters("Perl", (2,22,19,9)),   "Raku";
is jumping-letters("Raku", (24,4,7,17)),   "Perl";
is jumping-letters("Perl", (54,74,71,61)), "Raku";
is jumping-letters("Raku", (76,56,59,69)), "Perl";

sub jumping-letters($word, *@jump)
{
    sub jump($letter, $jump is copy)
    {
        my $adjust = $letter.ord < 97 ?? 65 !! 97;
        $jump = ($letter.ord - $adjust + $jump) mod 26;
        ($adjust + $jump).chr
    }
    
    ($word.comb Z @jump).map({ jump(.[0], .[1]) }).join
}
