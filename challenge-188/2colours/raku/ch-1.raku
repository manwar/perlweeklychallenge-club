#!/usr/bin/env raku

subset Listy of Str where /^ '(' [\d+] ** 0..* % [\s* ',' \s*] ')' $/;

sub MAIN(
  Listy $list,
  Int $k where * != 0 
) {
  $list
    .comb: /\d+/ andthen
    .combinations: 2 andthen
    .map: *.sum %% $k andthen
    .sum
    .say;    
}