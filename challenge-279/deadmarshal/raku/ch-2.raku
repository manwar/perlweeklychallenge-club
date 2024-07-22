#!/usr/bin/env raku

sub split-string($str)
{
  $str.lc.comb(/<[aeiou]>/).elems %% 2
}

say split-string('perl');
say split-string('book');
say split-string('good morning');

