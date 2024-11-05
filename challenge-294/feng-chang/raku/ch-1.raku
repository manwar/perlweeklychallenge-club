#!/bin/env raku

unit sub MAIN(*@ints);

@ints .= sort;

my $answer = 0;
my $m = 0;
while $m < +@ints - 1 {
    my $cnt = 1;
    while $m < +@ints - 1 and @ints[$m] + 1 == @ints[$m + 1] {
        ++$cnt;
        ++$m;
    }
    $answer = $cnt if $cnt > $answer;

    ++$m;
}

put $answer > 1 ?? $answer !! -1;
