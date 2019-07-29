#!/usr/bin/env perl6

use v6;



#| Read from STDIN and wrap to the given number of characters
multi sub MAIN (
    UInt() $width = 80, #= Width to wrap to (default 80 characters)
) {
    my $out = "";
    my $left = $width;
    for $*IN.words -> $word {
        if $word.codes + 1 > $left {
            say $out;
            $out = "";
            $left = $width;
        } 
        $out = $out ?? "$out $word" !! $word;
        $left = $width - $out.codes;
    }
    say $out if $out;
}


#| Display help
multi sub MAIN( Bool :h(:$help) where ?*  ) { say $*USAGE }
