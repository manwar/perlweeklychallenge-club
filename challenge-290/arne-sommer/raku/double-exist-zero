#! /usr/bin/env raku

unit sub MAIN (*@ints where all(@ints) ~~ Int && @ints.elems > 0);

my @unique = @ints.unique.grep: * != 0;
my @double = @unique.map: * * 2;

if @ints.grep(* == 0).elems > 1
{
  say True;
}
else
{
  say so ( any(@unique) == any(@double) );
}
