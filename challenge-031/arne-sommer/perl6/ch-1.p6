#! /usr/bin/env raku

unit sub MAIN (Numeric $a = 10, Numeric $b = 0);

my $c = $a / $b;

try say "a/b = $c";

say "Division by zero detected." if $!;
