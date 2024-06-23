#! /usr/bin/env raku

unit sub MAIN ($sentence where $sentence.chars > 0);

say $sentence.words.map( *.&goatify-word ).join(" ");

sub goatify-word ($word is copy)
{
  state $add = 2;

  $word = $word.substr(1) ~ $word.substr(0,1) if $word !~~ /^<[aeiou]>/;

  $word ~= "m" ~ "a" x $add++;

  return $word;
}
