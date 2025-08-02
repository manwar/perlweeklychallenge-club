#!/bin/env raku

unit sub MAIN(Str:D $str where /^<alnum>*$/);

put max(
    3 - .match(/<lower>/).Bool - .match(/<upper>/).Bool - .match(/<digit>/).Bool,
    .match(/(.)$0$0+/, :g).map({ .chars div 3 }).sum,
    6 - .chars,
) with $str;
