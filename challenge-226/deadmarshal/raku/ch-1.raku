#!/usr/bin/env raku

sub shuffle-string($str,@arr)
{
  my @ret;
  [0..@arr.end].map({@ret[@arr[$_]] = substr $str,$_,1});
  @ret.join
}

say shuffle-string('lacelengh',[3,2,0,5,4,8,6,7,1]);
say shuffle-string('rulepark',[4,7,3,1,0,5,2,6]);

