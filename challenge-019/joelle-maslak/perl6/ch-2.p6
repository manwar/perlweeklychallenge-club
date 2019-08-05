#!/usr/bin/env perl6
use v6;

sub MAIN(UInt:D $col where * > 0) {
    my $words = $*IN.words;

    my $line = '';
    for @$words -> $word {
        if $line.chars + $word.chars + 1 > $col {
            say $line;
            $line = "";

            if $word.chars > $col {
                die("Words must be ≤ $col columns long to be wrapped at column $col");
            }
        }
        $line ~= " " unless $line.chars == 0;
        $line ~= $word;
    }
    say $line unless $line.chars == 0;
}


