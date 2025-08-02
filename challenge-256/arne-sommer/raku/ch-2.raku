#! /usr/bin/env raku

unit sub MAIN ($str1 where $str1.chars > 0,
               $str2 where $str2.chars > 0);

say roundrobin($str1.comb, $str2.comb)>>.join.join;
