#! /usr/bin/env raku

unit sub MAIN ($str,
               Int $width where $width >= $str.chars);

say ("*" x ($width - $str.chars) / 2)
  ~ $str
  ~ ("*" x (($width - $str.chars) / 2) + 0.5);

