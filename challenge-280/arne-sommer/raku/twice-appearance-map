#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[a..z]>+$/);

$str.comb.map({ state %seen; (say $_; last) if %seen{$_}++ });
