#!/usr/bin/env raku

my @list = 1 => 2, 2 => 3, 3 => 4, 4 => Nil;

for ^@list/2 {
    my $A := @list[$_];
    my $Z := @list[* - 1 - $_];
    ($A, $Z) = ($A.key => $Z.key), ($Z.key => $A.value);
}

@list[*/2] = @list[*/2].key => Nil;

say @list.map({.key, .value}).flat[^*/2].join(" → ");
