#! /usr/bin/env raku

unit sub MAIN (Str $str is copy, :v(:$verbose));

say ": $str" if $verbose;

while $str ~~ / \d+ \[ /
{
  $str ~~ s[ $<k> = \d+ \[ $<s> = <-[\[\]]>* \] ] = ~$<s> x $<k>.Int;

  say ": $str" if $verbose;
}

say $str;