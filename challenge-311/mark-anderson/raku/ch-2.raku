#!/usr/bin/env raku
use Test;

is group-digit-sum(111122333, 3),    359;
is group-digit-sum(1222312, 2),       76;
is group-digit-sum(100012121001, 4), 162;

multi group-digit-sum($str, $int where * >= $str.chars) { return $str }

multi group-digit-sum($str, $int) 
{ 
    group-digit-sum($str.comb($int)>>.comb>>.sum.join, $int) 
}
