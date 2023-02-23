#!/usr/bin/env raku

sub maximum-xor(@arr)
{
  my $max = 0;
  for 0..@arr.end -> $i
  {
    for 0..@arr.end -> $j
    {
      if $max < (@arr[$i] +^ @arr[$j])
      {
	$max = (@arr[$i] +^ @arr[$j]);
      }
    }
  }
  $max;
}

say maximum-xor([1,2,3,4,5,6,7]);
say maximum-xor([2,4,1,3]);
say maximum-xor([10,5,7,12,8]);

