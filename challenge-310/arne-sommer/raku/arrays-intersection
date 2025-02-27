#! /usr/bin/env raku

unit sub MAIN ($arrays-as-string, :v(:$verbose));

my @list = $arrays-as-string.split(" ")>>.split(",");

say ": List: { @list.raku }" if $verbose;

say "(" ~ ([(&)] @list).keys.sort.join(",") ~ ")";
