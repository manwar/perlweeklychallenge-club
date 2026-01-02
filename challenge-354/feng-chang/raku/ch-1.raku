#!/bin/env raku

unit sub MAIN(*@ints);

my @pairs = +«@ints.sort.rotor(2 => -1).map(*.Array);
my $min-diff = @pairs.map({ -([-] @$_) }).min;
put @pairs.grep({ -([-] @$_) == $min-diff }).map({ "[{.join(', ')}]" }).join(', ');
