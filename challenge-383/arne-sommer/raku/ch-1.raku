#! /usr/bin/env raku

unit sub MAIN ($list1, $list2, $list3, :v(:$verbose));

my @list1 = $list1.words;
my @list2 = $list2.words;
my @list3 = $list3.split("|")>>.words;

unless @list1.elems == @list2.elems
{
  say ": List 1&2 must have the same length" if $verbose;
  say False;
  exit;
}

my %alias;

for @list3 -> @map;
{
  for @map -> $left;
  {
    for @map -> $right
    {
      next if $left eq $right;
      %alias{$left}.push: $right;
      say ": Alias '$left' -> '$right'" if $verbose;
    }
  }
}

my $similar = True;

for ^@list1.elems -> $index
{
  say ": Index $index: Compare '@list1[$index]' and '@list2[$index]'" if $verbose;

  if @list1[$index] eq @list2[$index]
  {
    say ": - Same word" if $verbose;
    next;
  }

  if any(@(%alias{@list1[$index]})) eq @list2[$index]
  {
    say ": - Aliased to same word" if $verbose;
    next;
  }
  
  say ": - No match" if $verbose;
  $similar = False;
  last;
}

say $similar;
