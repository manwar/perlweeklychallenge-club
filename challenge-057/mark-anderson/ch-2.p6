#!/usr/bin/env raku

my @words = <alphabet book carpet cadmium cadeau alpine>;

my @prefixes = gather {
    for @words -> $word {
        my $prefix;
        my $length = 0;

        repeat {
            $length++;
            $prefix = $word.substr(0, $length);
        } while @words.grep(* ne $word) ~~ / ^ $prefix /; 

        take $prefix;
    }
}

say @prefixes;
