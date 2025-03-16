#! /usr/bin/env raku

subset RGB where /^(<[RGB]><[0..9]>)+$/;

unit sub MAIN (RGB $str is copy, :v(:$verbose));

my %boxes;

while $str.chars
{
  my $ball   = $str.substr(0,2);
  my $colour = $str.substr(0,1);
  my $box    = $str.substr(1,1);
  $str       = $str.substr(2);

  %boxes{$box}{$colour}++;

  say ":Ball $ball (Colour $colour, Box $box)" if $verbose;
}

say %boxes>>.elems.grep( *.value == 3 ).elems;
