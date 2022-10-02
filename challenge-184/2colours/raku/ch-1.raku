#!/usr/bin/env raku


my @list-numbers <==
  prompt '@list = ' andthen
  .comb: / <[a..z]> ** 2 <[0..9]> ** 4 / andthen
  .map: *.substr(2);

('00' ... *) <<~<< @list-numbers ==>
  map "'" ~ * ~ "'"  ==>
  join ', ' ==>
  printf("(%s)\n");