#! /usr/bin/env raku

unit sub MAIN ($str where $str ~~ /^<[a..z]> <[a..z 0..9]>*$/ && $str.chars > 0);

$str.comb.map( *.&do-magic ).join.say;

sub do-magic ($letter)
{
  state $prev = "";

  return ($prev.ord + $letter).chr if $letter eq any('0' .. '9');

  $prev = $letter;

  return $letter;
}
