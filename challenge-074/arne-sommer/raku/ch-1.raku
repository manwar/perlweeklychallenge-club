#! /usr/bin/env raku

subset NonNegativeInt of Int where * >= 0;

unit sub MAIN (*@A where @A.elems >= 1 && all(@A) ~~ NonNegativeInt);

my $N = @A.elems;

my %count;

my $floor = floor($N / 2);

@A.map({ %count{$_}++ });

my $value = %count.keys.grep({ %count{$_} > $floor })[0];

say $value // '-1';
