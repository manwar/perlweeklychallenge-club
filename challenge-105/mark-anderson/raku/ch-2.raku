#!/usr/bin/env raku

use Test;
plan 8;

is name-game("Katie"),   chomp q:to/END/; 
                         Katie, Katie, bo-batie,
                         Bonana-fanna fo-fatie
                         Fee fi mo-matie
                         Katie!
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

is name-game("Arnold"),  chomp q:to/END/;
                         Arnold, Arnold, bo-barnold,
                         Bonana-fanna fo-farnold
                         Fee fi mo-marnold
                         Arnold!
                         END

is name-game("Aaron"),   chomp q:to/END/;
                         Aaron, Aaron, bo-baaron,
                         Bonana-fanna fo-faaron
                         Fee fi mo-maaron
                         Aaron!
                         END

is name-game("Billy"),   chomp q:to/END/;
                         Billy, Billy, bo-illy,
                         Bonana-fanna fo-filly
                         Fee fi mo-milly
                         Billy!
                         END

is name-game("Fred"),    chomp q:to/END/;
                         Fred, Fred, bo-bed,
                         Bonana-fanna fo-ed
                         Fee fi mo-med
                         Fred!
                         END

is name-game("Marsha"),  chomp q:to/END/;
                         Marsha, Marsha, bo-barsha,
                         Bonana-fanna fo-farsha
                         Fee fi mo-arsha
                         Marsha!
                         END

sub name-game($X)
{
    my $Y = lc $X ~~ / :i <[aeiou]> \w+ $ /;

    my $first = lc $X.substr: 0, 1;

    .join: "\n" given 

    "$X, $X, bo-"      ~ ($first eq "b" ?? "" !! "b") ~ $Y ~ ",", 
    "Bonana-fanna fo-" ~ ($first eq "f" ?? "" !! "f") ~ $Y,
    "Fee fi mo-"       ~ ($first eq "m" ?? "" !! "m") ~ $Y,
    "$X!"; 
}
