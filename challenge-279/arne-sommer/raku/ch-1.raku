#! /usr/bin/env raku

unit sub MAIN ($letters where $letters.chars > 0,
               *@weight where @weight.elems eq $letters.chars && all(@weight) ~~ UInt);

say ($letters.comb Z @weight).sort({ $^a.[1] <=> $^b.[1] }).map( *.[0] ).join;
