#!/usr/bin/env raku

my @list <==
  prompt '@list = ' andthen
  .comb: / \' .*? \' /;
  
s:4x/ <[0..9a..z]> /x/ for @list;
say "(@list.join(', '))";