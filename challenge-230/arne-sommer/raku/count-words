#! /usr/bin/env raku

unit sub MAIN ($prefix, *@words where @words.elems > 0, :v(:$verbose));

my @matching = @words.grep( *.starts-with($prefix) );

say ": Matches: { @matching.map('"' ~ * ~ '"').join(", ") }" if $verbose;

say @matching.elems;
