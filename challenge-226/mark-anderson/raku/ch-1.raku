#!/usr/bin/env raku
use Test;

is shuffle-string('lacelengh', [3,2,0,5,4,8,6,7,1]), 'challenge';
is shuffle-string('rulepark',  [4,7,3,1,0,5,2,6]),   'perlraku';

sub shuffle-string($s, @a)
{
    (@a Z=> $s.comb).sort>>.value.join
}
