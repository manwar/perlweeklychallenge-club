#! /usr/bin/env raku

unit sub MAIN (*@words where @words.elems > 0,
               :v(:$verbose),
               :d(:$duplicates));

my @ok;

for @words -> $substring
{
  for @words -> $word
  {
    next if $substring eq $word;

    if $word ~~ /.$substring/ || $word ~~ /$substring./
    {
      say ":Word '$substring' is a substring of '$word'" if $verbose;
      @ok.push: $substring;
      last;
    }
  }
}

say $duplicates
  ?? "(" ~ @ok.map({ '"' ~ $_ ~ '"' }).join(", ") ~ ")"
  !! "(" ~ @ok.unique.map({ '"' ~ $_ ~ '"' }).join(", ") ~ ")";



