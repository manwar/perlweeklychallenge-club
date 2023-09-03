#!/bin/env raku

unit sub MAIN(*@S);

put @S.map({ .lc.comb.Set }).reduce(&infix:<(&)>).keys.sort.join(', ');
