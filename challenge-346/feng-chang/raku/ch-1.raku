#!/bin/env raku

unit sub MAIN(Str:D $s where *.comb.all eq <( )>.any);

my token Parens { '(' <&Parens>* ')' };

put $s.match(/<Parens>+/, :ex)».chars.max;
