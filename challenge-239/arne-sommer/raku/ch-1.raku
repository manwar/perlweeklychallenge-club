#! /usr/bin/env raku

unit sub MAIN ($arr1, $arr2);

say $arr1.words.join eq $arr2.words.join
  ?? 'true'
  !! 'false';
