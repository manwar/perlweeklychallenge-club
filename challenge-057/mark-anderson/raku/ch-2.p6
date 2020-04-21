#!/usr/bin/env raku

my @words = <alphabet book carpet cadmium cadeau alpine>;

my @prefixes = gather {
    for @words -> $word {
        my $length;
        my $prefix;
        my @rest = @words;

        repeat {
            $length++;
            $prefix = $word.substr(0, $length); 
            @rest = @rest.grep(/^$prefix/); 
        } while @rest > 1;

        take $prefix;
    }
}

say @prefixes;
