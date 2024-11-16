#!/usr/bin/env raku
use Test;

ok  word-break("weeklychallenge", <challenge weekly>);
ok  word-break("perlrakuperl", <raku perl>);
nok word-break("sonsanddaughters", <sons sand daughters>);

sub word-break($str, @words)
{
    $str ~~ /^ [ @words ]* $/
}
