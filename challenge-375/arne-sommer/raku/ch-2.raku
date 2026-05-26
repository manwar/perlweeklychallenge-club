#! /usr/bin/env raku

unit sub MAIN ($array1, $array2, :v(:$verbose));

my @array1  = $array1.words;
my @array2  = $array2.words;

my @unique1 = @array1.Bag.grep( *.value == 1 )>>.key;
my @unique2 = @array2.Bag.grep( *.value == 1 )>>.key;

my @common  = @unique1 (&) @unique2;

if $verbose
{
  say ": Array1: @array1[]";
  say ": Array2: @array2[]";
  say ": Unique1: @unique1[]";
  say ": Unique2: @unique2[]";
  say ": Common: { @common>>.key }";
}

say @common.elems;
