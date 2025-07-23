#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
               :v(:$verbose));

say ": Last word: '{ $str.words.tail }'" if $verbose;

say $str.words.tail.chars;
