#! /usr/bin/env raku

unit sub MAIN (Str $S where $S.chars > 0,
               Str $P is copy where $P.chars > 0,
	       :v(:$verbose));

$P.=trans( [ '*', '?' ] => [ '.*' , '.' ]);

say ": Regex: $P " if $verbose;

say $S ~~ /^ <$P> $/ ?? 1 !! 0
