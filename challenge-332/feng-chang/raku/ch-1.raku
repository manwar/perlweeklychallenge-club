#!/bin/env raku

unit sub MAIN(Str:D $date where *.Date);

put $date.comb(/\d+/).map(*.Int.base(2)).join('-');
