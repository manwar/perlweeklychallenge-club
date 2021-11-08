#!/usr/bin/env raku

my @player-ages = < 20 Alex  >,
                  < 28 Joe   >,
                  < 38 Mike  >,
                  < 18 Alex  >,
                  < 25 David >,
                  < 18 Simon >;

my @player-names = < Alex  Stewart >,
                   < Joe   Root    >,
                   < Mike  Gatting >,
                   < Joe   Blog    >,
                   < Alex  Jones   >,
                   < Simon Duane   >;

my %a  = % .classify-list: :as{ .[0] }, { .[1], 'ages'  }, @player-ages;
   %a .=    classify-list: :as{ .[1] }, { .[0], 'names' }, @player-names;

for %a.keys.sort -> $k
{
    my %b = %a{$k};

    if %b<ages>:exists and %b<names>:exists
    {
         for %b<ages><> X %b<names><>
         {
             printf "%-3d%-6s%s\n", .[0], $k, .[1];
         }
    }
}
