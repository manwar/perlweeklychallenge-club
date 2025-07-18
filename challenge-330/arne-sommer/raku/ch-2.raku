#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
               :v(:$verbose));

say $str.words.map( *.&tica ).join(" ");

sub tica ($word)
{
  say ": Word: $word" if $verbose;

  return $word.lc if $word.chars <= 2;
  return $word.lc.tc;
}
