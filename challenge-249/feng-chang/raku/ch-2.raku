#!/bin/env raku

unit sub MAIN(Str:D $s where *.comb.all eq <D I>.any);

my @a = 0..$s.chars;
my @b = gather {
    for $s.comb {
        when 'D' { take @a.pop }
        when 'I' { take @a.shift }
    }
    take @a[0];
}
put '(', @b.join(', ') , ')';
