#!/bin/env raku

unit sub MAIN(*@N);

@N .= sort;
my @a = @N.splice((+@N + 1) div 2);

loop (my $i = 1; +@a > 0; $i += 2) {
    @N.splice($i, 0, @a.shift);
}

put @N.join(', ');
