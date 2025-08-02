#!/bin/env raku

unit sub MAIN(Str:D $s is copy);

$s .= subst(/<lower><digit>/) while $s.contains(/<lower><digit>/);
put $s;
