#!/usr/bin/env raku
use Test;

is good-strings(<cat bt hat tree>,       'atach'),           6;
is good-strings(<hello world challenge>, 'welldonehopper'), 10;
is good-strings(<attach chat atacha>,    'atach'),           4;
is good-strings(<hello world challenge>, 'weldonehopper'),   5;

sub good-strings($words, $chars)
{
   my $c = $chars.comb.Bag;

   sum map { .chars }, $words.grep(
                       { 
                           my $w = .comb.Bag;
                           so all $w.map({ $c{.key} >= .value })
                       })
}
