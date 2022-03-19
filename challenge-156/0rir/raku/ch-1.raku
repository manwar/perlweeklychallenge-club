#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtabs
use v6.d;

#1 Pernicious Numbers

(gather {
    for 1…∞  {
        .take if .base(2).split('').grep( '1' ).chars.is-prime()
    }
})[0..9].join( ', ', :skip-empty ).say;

