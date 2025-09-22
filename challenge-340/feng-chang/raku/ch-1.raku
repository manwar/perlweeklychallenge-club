#!/bin/env raku

unit sub MAIN(Str:D $s is copy);

$s .= subst(/(.)$0/) while $s.contains(/(.)$0/);
put $s;
