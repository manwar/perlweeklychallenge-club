#! /usr/bin/env raku

unit sub MAIN ($items1, $items2, :v(:$verbose));

my @items1 = $items1.split("|")>>.words>>.Int;
my @items2 = $items2.split("|")>>.words>>.Int;

if $verbose
{
  say ": items1: { @items1.raku }";
  say ": items2: { @items2.raku }";
}

my %count;

for @items1 -> $item
{
  say ": item1 ID $item[0] with frequency $item[1]";
  %count{$item[0]} += $item[1];
}

for @items2 -> $item
{
  say ": item2 ID $item[0] with frequency $item[1]";
  %count{$item[0]} += $item[1];
}

my @output;

for sort keys %count -> $key
{
  @output.push: ($key.Int, %count{$key});
}

say @output.raku;
