#!/usr/bin/env raku
use Test;

is good-strings(<cat bt hat tree>,       'atach'),           6;
is good-strings(<hello world challenge>, 'welldonehopper'), 10;
is good-strings(<attach chat atacha>,    'atach'),           4;

# with help from https://blogs.perl.org/users/laurent_r/2023/06/perl-weekly-challenge-221-good-strings.html
sub good-strings($words, $chars)
{
   .join.chars given grep { .comb.Bag (<=) $chars.comb.Bag }, |$words
}
