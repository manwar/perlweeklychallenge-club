#! /usr/bin/env raku

unit sub MAIN ($char  where $char ~~ /^<[a..z A..Z]>$/,
               *@list where @list.elems > 0,
               :v(:$verbose));

my @matches;

for ^@list.elems -> $index
{
  my $match = @list[$index] ~~ /$char/;
  say ": Index $index Word: @list[$index] { $match ?? " - match" !! "" }" if $verbose;

  @matches.push: $index if $match;
}

say "({ @matches.join(", ") })";
