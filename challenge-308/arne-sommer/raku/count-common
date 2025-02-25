#! /usr/bin/env raku

unit sub MAIN ($str1, $str2, :v(:$verbose));

my @str1   = $str1.words;
my @str2   = $str2.words;
my @common = @str1 (&) @str2;

say ": Common: { @common>>.key.sort.join(", ") }" if $verbose;

say @common.elems;
