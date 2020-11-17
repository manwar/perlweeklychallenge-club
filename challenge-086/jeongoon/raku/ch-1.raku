#!/usr/bin/env raku

# test with:
# raku ch-1.raku 7 1 5 2 9 7 # first one is $A

unit sub MAIN (Int \A, *@N where { .all ~~ Int and .elems > 1 } );

my @n = @N.sort;
loop ( my $i = 1; $i < @n.elems; ) {
    given (@n[$i]- @n[0]) <=> A {
        when Less { ++$i }
        when More { shift @n; $i = 1 }
        default { say "1 as @n[$i] - @n[0] = {A}"; exit 0 }
    }
 }

"0".say;
exit 1;
