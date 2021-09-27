#!/usr/bin/env raku

my @players-age = (
    < 20 Alex  >,
    < 28 Joe   >,
    < 38 Mike  >,
    < 18 Alex  >,
    < 25 David >,
    < 18 Simon >,
);

my @players-name = (
    < Alex  Stewart >,
    < Joe   Root    >,
    < Mike  Gatting >,
    < Joe   Blog    >,
    < Alex  Jones   >,
    < Simon Duane   >,
);

my %a = @players-age.classify({ .[1] }, :as{ .[0] });
my %n = @players-name.classify({ .[0] }, :as{ .[1] });

for %a.keys.sort -> $k
{
    if %n{$k}:exists
    {    
        for %a{$k}<> X %n{$k}<>
        {
            printf("%-3d%-6s%s\n", .[0], $k, .[1]);
        }
    }
}
