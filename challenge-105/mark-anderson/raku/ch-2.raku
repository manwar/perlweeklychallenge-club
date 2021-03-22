#!/usr/bin/env raku

# I have no idea how to test whether the emphasis is on the first 
# or second syllable so I'm just testing for consonants and vowels.

use Test;
plan 4;

is name-game("Katie"),   chomp q:to/END/; 
                         Katie, Katie, bo-batie,
                         Bonana-fanna fo-fatie
                         Fee fi mo-matie
                         Katie!
                         END

is name-game("Aaron"),   chomp q:to/END/;
                         Aaron, Aaron, bo-baaron,
                         Bonana-fanna fo-faaron
                         Fee fi mo-maaron
                         Aaron!
                         END

is name-game("Charles"), chomp q:to/END/;
                         Charles, Charles, bo-barles,
                         Bonana-fanna fo-farles
                         Fee fi mo-marles
                         Charles!
                         END

is name-game("Shirley"), chomp q:to/END/;
                         Shirley, Shirley, bo-birley,
                         Bonana-fanna fo-firley
                         Fee fi mo-mirley
                         Shirley!
                         END

sub name-game($X)
{
    my $vowels     = rx/ <[AEIOUaeiou]>+ /;

    my $consonants = rx/ <[A..Za..z]-[AEIOUaeiou]>+ /;

    my $start = $X ~~ / ^ [$vowels|$consonants] /;

    my $Y = $start ~~ $consonants ?? $X.subst($start, "") !! lc $X;

    .join("\n") given "$X, $X, bo-b"      ~ $Y ~ ",", 
                      "Bonana-fanna fo-f" ~ $Y,
                      "Fee fi mo-m"       ~ $Y,
                      $X ~ "!"; 
}
