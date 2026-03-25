#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^ <[a..z]> $/,
               *@array where @array.elems > 0,
               :v(:$verbose));

my @ok = @array.grep({ $str.starts-with: $_ });

say ": Matches: { @ok.join(", ") }" if $verbose;

say @ok.elems;
