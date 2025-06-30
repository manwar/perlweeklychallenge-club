#!/bin/env raku

unit sub MAIN(Str:D $s where *.match: /^ <[?a..z]>+ $/);

put $s.subst(/(.)'?'(.)/, { ~$0 ~ (<a b c> (-) (~$0, ~$1)).keys.sort[0] ~ $1 }, :g);
