#! /usr/bin/env raku

unit sub MAIN ($str, :v(:$verbose));

my @parts = $str.split(/\|.*?\|/);

say ": Parts: { @parts.raku }" if $verbose;

@parts.join.comb.grep( * eq '*').elems.say;