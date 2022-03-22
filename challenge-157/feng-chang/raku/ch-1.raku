#!/bin/env raku

unit sub MAIN(*@a);

my UInt \n = @a.elems;
put 'AM = ', (@a.sum / n)         .fmt('%.2f'), ', ',
    'GM = ', (([*] @a) ** (1/n))  .fmt('%.2f'), ', ',
    'HM = ', (n / @a.map(1/*).sum).fmt('%.2f');
