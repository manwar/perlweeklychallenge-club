#!/usr/bin/env raku

sub b-after-a($str)
{
  ?($str ~~ /bb/)
}

say b-after-a('aabb');
say b-after-a('abab');
say b-after-a('aaa');
say b-after-a('bbb');

