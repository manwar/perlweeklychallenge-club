#! /usr/bin/env raku

unit sub MAIN (Str $A, Str $B);

my @A = $A.words;
my @B = $B.words;

die '@A must be positive numbers only' unless all(@A) > 0;
die '@B must be legal indices only'   unless 0 <= all(@B) <= @A.end;

@B.map({ say '[' ~ @A.rotate($_).join(' ') ~ ']' });