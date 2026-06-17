#! /usr/bin/env raku

subset ALPHANUM where /^ <[a..z A..Z 0..9]>+ $ /;

unit sub MAIN (ALPHANUM $str, :v(:$verbose));

my @distinct = $str.comb.grep( * ~~ /\d/ ).sort(-*).unique;

say ": Distinct digits: { @distinct.elems ?? @distinct.join(",") !! "none" }" if $verbose;

say @distinct.elems > 1
  ?? @distinct[1]
  !! '-1';
