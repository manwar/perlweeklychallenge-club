#!/bin/env raku

unit sub MAIN(*@ints);

my %remain is SetHash = |@ints;
my @loops;

while %remain {
    my @cache;
    my $i = %remain.keys.min;

    repeat {
        $i = @ints[$i];
        @cache.grep($i) ?? last() !! @cache.push($i);
    } while True;

    @loops.push(@cache);
    %remain.unset($_) for @cache;
}

put +@loops;
